library IEEE;
use ieee.std_logic_1164.all;

entity NAND2 is
port (
    x1, x2: in std_logic;
    o: out std_logic
);
end NAND2;

architecture rtl of NAND2 is
begin
    o <= x1 nand x2 after 1 ns;
end rtl;