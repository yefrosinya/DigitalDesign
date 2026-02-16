library ieee;
use ieee.std_logic_1164.all;

-- Task 3
-- I = 6F (16) = 0110_1111 (2)
-- J = 8C (16) = 1000_1100 (2)

-- J = X xor I
-- X = 1110_0011 - sw_i[7:0] value

entity comb_led_unit is
    port (
                                               
        sw_i    : in    std_logic_vector(15 downto 0);
        led_o   : out   std_logic_vector(15 downto 0)
    );
end comb_led_unit;

architecture rtl of comb_led_unit is
    constant I  : std_logic_vector(7 downto 0) := "01101111";
begin
    led_o(15 downto 0) <= "00000000" & (I xor sw_i(7 downto 0));
end rtl;