library ieee;
use ieee.std_logic_1164.all;

-- I = E2 = 1110 0010
-- not xor
-- sw[7:0] = 1101 0100
-- J = C9 = 1100 1001

entity comb_led_unit is
    port (
        led : out std_logic_vector(15 downto 0);
        sw: in std_logic_vector(7 downto 0)
    );
end comb_led_unit;

architecture rtl of comb_led_unit is
begin 
    led(15 downto 8) <= X"00";
    led(7 downto 0) <= not (X"E2" xor sw); 
end rtl;