library ieee;
use ieee.std_logic_1164.all;

entity task1 is
    port (
        led : out std_logic_vector(15 downto 0)
    );
end task1;

architecture rtl of task1 is
begin 
    -- K = 7C4E = 0111 1100 0100 1110
    led <= "0111110001001110";
end rtl;