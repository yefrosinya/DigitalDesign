library ieee;
use ieee.std_logic_1164.all;

entity AND2 is
    port (
        X1  : in    std_logic;
        X2  : in    std_logic;
        Y   : out   std_logic
    );
end AND2;

architecture rtl of AND2 is
begin
    Y <= X1 and X2;
end rtl;