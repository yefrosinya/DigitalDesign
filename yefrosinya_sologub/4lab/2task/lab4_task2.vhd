library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
 
entity lab4_task2 is 
generic ( 
    CLK_BEAT: positive := 99_999_999; 
    BLINK_BEAT: positive := 24_999_999 
); 
port( 
    CLK, RST, MODE, CAR_SENSOR, MANUAL_NEXT: in std_logic; 
    MAIN_RED, MAIN_YELLOW, MAIN_GREEN, SEC_RED, SEC_YELLOW, SEC_GREEN: out std_logic 
); 
end lab4_task2; 
 
architecture rtl of lab4_task2 is 
    type t_states is (S_MAIN_GREEN, S_MAIN_GREEN_BLINK, S_MAIN_YELLOW, S_SEC_GREEN, S_SEC_YELLOW); 
    signal cur_state: t_states := S_MAIN_GREEN; 
    signal active_mode: std_logic := '0'; 
    signal timer: natural := 0; 
    signal clk_cnt: natural range 0 to CLK_BEAT := 0; 
    signal tick: std_logic := '0'; 
    signal blink_cnt: natural range 0 to BLINK_BEAT := 0; 
    signal blink_2hz: std_logic := '0';  
    signal btn_reg : std_logic := '0'; 
    signal btn_edge : std_logic := '0'; 
 
begin 
    process(CLK) 
    begin 
        if rising_edge(CLK) then 
            if clk_cnt = CLK_BEAT then 
                clk_cnt <= 0; 
                tick <= '1'; 
            else 
                clk_cnt <= clk_cnt + 1; 
                tick <= '0'; 
            end if; 
            if blink_cnt = BLINK_BEAT then 
                blink_cnt <= 0; 
                blink_2hz <= not blink_2hz; 
            else 
                blink_cnt <= blink_cnt + 1; 
            end if; 
            btn_reg <= MANUAL_NEXT; 
            if (MANUAL_NEXT = '1' and btn_reg = '0') then 
                btn_edge <= '1'; 
            else 
                btn_edge <= '0'; 
            end if; 
        end if; 
    end process; 
 
    process(CLK) 
    begin 
        if rising_edge(CLK) then 
            if RST = '1' then 
                cur_state <= S_MAIN_GREEN; 
                timer <= 0; 
                active_mode <= MODE; 
            else 
                case cur_state is 
                    when S_MAIN_GREEN => 
                        active_mode <= MODE;  
                        if active_mode = '0' then 
                            if tick = '1' then 
                                if (CAR_SENSOR = '1' or timer >= 9) then 
                                    cur_state <= S_MAIN_GREEN_BLINK; 
                                    timer <= 0; 
                                else 
                                    timer <= timer + 1; 
                                end if; 
                            end if; 
                        else  
                            if btn_edge = '1' then 
                                cur_state <= S_MAIN_YELLOW; 
                                timer <= 0; 
                            end if; 
                        end if; 
 
                    when S_MAIN_GREEN_BLINK => 
                        if tick = '1' then 
                            if timer >= 2 then 
                                cur_state <= S_MAIN_YELLOW; 
                                timer <= 0; 
                            else 
                                timer <= timer + 1; 
                            end if; 
                        end if; 
 
                    when S_MAIN_YELLOW => 
                        if (active_mode = '0' and timer >= 1 and tick = '1') or 
                           (active_mode = '1' and btn_edge = '1') then 
                            cur_state <= S_SEC_GREEN; 
                            timer <= 0; 
                        elsif tick = '1' then 
                            timer <= timer + 1; 
                        end if; 
                   when S_SEC_GREEN => 
                        if active_mode = '0' then 
                            if tick = '1' then 
                                if (timer >= 2 and CAR_SENSOR = '0') or (timer >= 5) then 
                                    cur_state <= S_SEC_YELLOW; 
                                    timer <= 0; 
                                else 
                                    timer <= timer + 1; 
                                end if; 
                            end if; 
                        else
                            if btn_edge = '1' then 
                                cur_state <= S_SEC_YELLOW; 
                                timer <= 0; 
                            end if; 
                        end if; 
 
                    when S_SEC_YELLOW => 
                        if (active_mode = '0' and timer >= 1 and tick = '1') or 
                           (active_mode = '1' and btn_edge = '1') then 
                            cur_state <= S_MAIN_GREEN; 
                            timer <= 0; 
                        elsif tick = '1' then 
                            timer <= timer + 1; 
                        end if; 
                end case; 
            end if; 
        end if; 
    end process; 
 
    MAIN_GREEN <= blink_2hz when cur_state = S_MAIN_GREEN_BLINK else  
                   '1' when cur_state = S_MAIN_GREEN else '0'; 
    MAIN_YELLOW <= '1' when cur_state = S_MAIN_YELLOW else '0'; 
    MAIN_RED <= '1' when (cur_state = S_SEC_GREEN or cur_state = S_SEC_YELLOW) else '0'; 
 
    SEC_GREEN <= '1' when cur_state = S_SEC_GREEN else '0'; 
    SEC_YELLOW <= '1' when cur_state = S_SEC_YELLOW else '0'; 
    SEC_RED <= '1' when (cur_state = S_MAIN_GREEN or cur_state = S_MAIN_GREEN_BLINK or cur_state = S_MAIN_YELLOW) else '0'; 
 
end rtl;