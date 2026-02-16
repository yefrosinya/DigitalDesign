library ieee;
use ieee.std_logic_1164.all;

entity sw_led_unit is
    port (
        led : out std_logic_vector(15 downto 0);
        sw: in std_logic_vector(15 downto 0)
    );
end sw_led_unit;

architecture rtl of sw_led_unit is
begin 
    led <= sw;
end rtl;