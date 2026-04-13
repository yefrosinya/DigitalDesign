library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use ieee.math_real.all; 
 
entity freq_div_behav is 
    generic (K : natural := 8); 
    port ( 
        CLK, RST, EN: in  std_logic; 
        Q : out std_logic 
    ); 
end freq_div_behav; 
 
architecture rtl of freq_div_behav is 
    constant WIDTH : positive := integer(ceil(log2(real(K)))); 
    signal counter : unsigned(WIDTH-1 downto 0) := (others => '0'); 
begin 
 
    proc: process(CLK) 
    begin 
        if rising_edge(CLK) then 
            if RST = '1' then 
                counter <= (others => '0'); 
            elsif EN = '1' then 
                if counter = K-1 then 
                    counter <= (others => '0'); 
                else 
                    counter <= counter + 1; 
                end if; 
            end if; 
        end if; 
    end process; 
 
    Q <= counter(WIDTH-1); 
 
end rtl;
