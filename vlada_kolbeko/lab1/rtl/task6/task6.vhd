library ieee;
use ieee.std_logic_1164.all;

-- Task 6
-- Input code - Berger Code (4 bit, 2 bits sw_i(3:2) - data, 2 bits sw_i(1:0) - control)
-- Output code - 6321 (4 bits led_o(3:0))

entity code_conv is
    port (
        sw_i    : in    std_logic_vector(15 downto 0);
        led_o   : out   std_logic_vector(15 downto 0)
    );
end code_conv;

architecture behavioral of code_conv is
begin
    process (sw_i)
    begin
        led_o(15 downto 4) <= (others => '0');
    
        case sw_i(3 downto 0) is
            when "0010" =>
                led_o(3 downto 0) <= "0000";
            when "0101" =>
                led_o(3 downto 0) <= "0001";
            when "1001" =>
                led_o(3 downto 0) <= "0010";
            when "1100" =>
                led_o(3 downto 0) <= "0100";
            when others =>
                led_o(3 downto 0) <= "0000";
        end case;
    end process;
end behavioral;