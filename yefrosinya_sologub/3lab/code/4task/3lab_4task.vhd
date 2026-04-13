library IEEE; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use ieee.math_real.all; 
 
entity freq_div_behav is 
    generic (K : natural := 10); 
    port ( 
        CLK, RST, EN : in std_logic; 
        Q: out std_logic 
    ); 
end freq_div_behav; 
 
architecture rtl of freq_div_behav is 
    constant HALF: positive := K/2; 
    constant WIDTH: positive := integer(ceil(log2(real(HALF + 1)))); 
    signal counter: std_logic_vector(WIDTH-1 downto 0); 
    signal store: std_logic := '0'; 
begin 
 
    count_proc: process(CLK) 
        begin 
        if rising_edge(CLK) then 
            if RST = '1' then 
                counter <= (others => '0'); 
            elsif EN = '1' then 
                if unsigned(counter) = HALF-1 then 
                    counter <= (others => '0'); 
                else 
                    counter <= std_logic_vector(unsigned(counter)+1); 
                end if; 
            end if; 
        end if; 
    end process; 
 
    toggle_proc: process(CLK) 
    begin 
        if rising_edge(CLK) then 
            if RST = '1' then 
                store <= '0'; 
            elsif EN = '1' and unsigned(counter) = HALF-1 then 
                store <= not store; 
            end if; 
        end if; 
    end process; 
 
   Q <= store; 
end rtl;
