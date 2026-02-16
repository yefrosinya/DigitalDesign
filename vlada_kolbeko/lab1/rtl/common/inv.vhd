library ieee;
use ieee.std_logic_1164.all;

entity INV is
    port (
        X   : in    std_logic;
        Y   : out   std_logic
    );
end INV;

architecture rtl of INV is
begin
    Y <= not X;
end rtl;