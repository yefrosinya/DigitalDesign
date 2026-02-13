library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity task5 is
    port (
        led : out std_logic_vector(5 downto 0);
        sw: in std_logic_vector(15 downto 0)
    );
end task5;

-- or, and, +, nand

architecture rtl of task5 is
begin 
    led(5 downto 0) <= 
        sw(15 downto 10) or sw(9 downto 4) when sw(0) = '1' else 
        sw(15 downto 10) and sw(9 downto 4) when sw(1) = '1' else
        sw(15 downto 10) + sw(9 downto 4) when sw(2) = '1' else
        sw(15 downto 10) nand sw(9 downto 4) when sw(3) = '1' else "000000";
end rtl;