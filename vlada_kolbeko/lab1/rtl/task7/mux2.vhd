library ieee;
use ieee.std_logic_1164.all;

entity MUX2 is
    port (
        X1  : in    std_logic;
        X2  : in    std_logic;
        S   : in    std_logic;
        Y   : out   std_logic
    );
end MUX2;

architecture rtl of MUX2 is
begin
    Y <= X1 when S = '0' else X2;
end rtl;