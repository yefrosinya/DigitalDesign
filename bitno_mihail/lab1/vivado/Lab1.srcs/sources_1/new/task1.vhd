library ieee;
use ieee.std_logic_1164.all;

entity led_const is
    port (
        led : out std_logic_vector(15 downto 0)
    );
end led_const;

architecture rtl of led_const is
begin 
    --A3F1 = 1010001111110001
    led <= "1010001111110001";
end rtl;