library ieee; 
use ieee.std_logic_1164.all; 
 
entity lab4_task4 is 
generic ( 
     BLINK_DIV : natural := 24_999_999; 
     GREEN_TICKS : natural := 499_999_999 
); 
port ( 
     CLK, RST, ADMIN_UNLOCK: in std_logic; 
     BTN: in std_logic_vector(2 downto 0); 
     LED_GREEN, LED_RED, LED_BLUE: out std_logic
); 
end lab4_task4; 
 
architecture rtl of lab4_task4 is 
 type t_state is (S_WAIT, S_S1, S_S2, S_ACCESS, S_DEADLOCK); 
 signal state: t_state := S_WAIT; 
 signal btn_prev: std_logic_vector(2 downto 0) := (others => '0'); 
 signal btn_rise: std_logic_vector(2 downto 0); 
 signal err_count: natural range 0 to 3 := 0; 
 signal blink_cnt: natural range 0 to BLINK_DIV := 0; 
 signal blink_reg: std_logic := '0'; 
 signal green_cnt: natural range 0 to GREEN_TICKS := 0; 
 signal green_done: std_logic := '0'; 
begin 
 btn_rise <= BTN and not btn_prev; 
 
 process(CLK, RST) 
 begin 
  if RST = '1' then 
   btn_prev <= (others => '0'); 
  elsif rising_edge(CLK) then 
   btn_prev <= BTN; 
  end if; 
 end process; 
 
 process(CLK, RST) 
 begin 
  if RST = '1' then 
   blink_cnt <= 0; 
   blink_reg <= '0'; 
  elsif rising_edge(CLK) then 
   if blink_cnt = BLINK_DIV then 
    blink_cnt <= 0; 
    blink_reg <= not blink_reg; 
   else 
    blink_cnt <= blink_cnt + 1; 
   end if; 
  end if; 
 end process; 
 
 process(CLK, RST) 
 begin 
  if RST = '1' then 
   green_cnt <= 0; 
   green_done <= '0'; 
  elsif rising_edge(CLK) then 
   green_done <= '0'; 
   if state = S_ACCESS then 
    if green_cnt = GREEN_TICKS then 
     green_cnt <= 0; 
     green_done <= '1'; 
    else 
     green_cnt <= green_cnt + 1; 
    end if; 
   else 
    green_cnt <= 0; 
   end if; 
  end if; 
 end process; 
 
 process(CLK, RST) 
 begin 
  if RST = '1' then 
   state <= S_WAIT; 
   err_count <= 0; 
  elsif rising_edge(CLK) then 
   case state is 
    when S_WAIT => 
     if btn_rise /= "000" then 
      if btn_rise = "001" then 
       state <= S_S1; 
      else 
       if err_count = 2 then 
        state <= S_DEADLOCK; 
       else 
        err_count <= err_count + 1; 
       end if; 
      end if; 
     end if; 
    when S_S1 => 
     if btn_rise /= "000" then 
      if btn_rise = "010" then 
       state <= S_S2; 
      else 
       if err_count = 2 then 
        state <= S_DEADLOCK; 
       else 
        err_count <= err_count + 1; 
        state <= S_WAIT; 
       end if; 
      end if; 
     end if; 
    when S_S2 => 
     if btn_rise /= "000" then 
      if btn_rise = "100" then 
       state <= S_ACCESS; 
       err_count <= 0; 
      else 
       if err_count = 2 then 
        state <= S_DEADLOCK; 
       else 
        err_count <= err_count + 1; 
        state <= S_WAIT; 
       end if; 
      end if; 
     end if; 
    when S_ACCESS => 
     if green_done = '1' then 
      state <= S_WAIT; 
     end if; 
    when S_DEADLOCK => 
     if ADMIN_UNLOCK = '1' and BTN(0) = '1' then 
      state <= S_WAIT; 
      err_count <= 0; 
     end if; 
   end case; 
  end if; 
 end process; 
 
 LED_GREEN <= '1' when state = S_ACCESS else '0'; 
 LED_RED <= '1' when state = S_DEADLOCK else '0'; 
 LED_BLUE <= blink_reg when state = S_WAIT else '0'; 
 
end rtl;