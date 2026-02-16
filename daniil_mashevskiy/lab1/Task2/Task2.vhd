library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Task2 is
port(
    sw : in std_logic_vector(15 downto 0);
    led : out std_logic_vector(15 downto 0)
);
end Task2;

architecture rtl of Task2 is
begin
    led <= sw;
end rtl;