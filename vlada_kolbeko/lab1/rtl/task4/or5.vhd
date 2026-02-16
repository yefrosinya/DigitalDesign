library ieee;
use ieee.std_logic_1164.all;

entity OR5 is
    port (
        X1  : in    std_logic;
        X2  : in    std_logic;
        X3  : in    std_logic;
        X4  : in    std_logic;
        X5  : in    std_logic;
        Y   : out   std_logic
    );
end OR5;

architecture rtl of OR5 is
begin
    Y <= X1 or X2 or X3 or X4 or X5;
end rtl;