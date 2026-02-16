library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Task3 is
port(
    sw : in std_logic_vector(15 downto 0);
    led : out std_logic_vector(15 downto 0)
);
end Task3;

architecture rtl of Task3 is
begin
    led(7 downto 0) <= sw(7 downto 0) xor "10001101";
    led(15 downto 8) <= (others => '0');
end rtl;