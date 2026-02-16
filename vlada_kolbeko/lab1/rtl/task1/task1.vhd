library ieee;
use ieee.std_logic_1164.all;

-- Task 1
-- K = 4D7A (16) = 0100_1101_0111_1010 (2)
-- N = 16

entity led_const is
    port (
        led_o   : out   std_logic_vector(15 downto 0) -- N-digit port
    );
end led_const;

architecture rtl of led_const is
    constant K  : std_logic_vector(15 downto 0) := "0010110101111010";
begin
    led_o <= K;
end rtl;