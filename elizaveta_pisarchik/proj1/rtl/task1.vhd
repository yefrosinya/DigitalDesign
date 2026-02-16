library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity task1 is
    port (
        led_o : out std_logic_vector (0 to 13)
    );
end task1;

architecture rtl of task1 is
 constant K : std_logic_vector(0 to 13) := b"11011010011000";
begin
   led_o <= K;
end rtl;