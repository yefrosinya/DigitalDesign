library ieee;
use ieee.std_logic_1164.all;

-- Task 2
-- N = 16 (from Task 1)

entity sw_led_unit is
    port (
        sw_i    : in    std_logic_vector(15 downto 0);
        led_o   : out   std_logic_vector(15 downto 0)
    );
end sw_led_unit;

architecture rtl of sw_led_unit is
begin
    led_o <= sw_i;
end rtl; 