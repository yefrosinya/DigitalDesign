library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity task6 is
    port (
        led : out std_logic_vector(3 downto 0);
        sw: in std_logic_vector(15 downto 12) -- b3, b2, b1, b0
    );
end task6;

-- G = 8421
-- L = 7210

architecture rtl of task6 is
    signal b0, b1, b2, b3: std_logic_vector(2 downto 0);
    signal zeros_sum: std_logic_vector(2 downto 0);
begin 
    p1: process (sw(3 downto 0))
    begin
        case sw(3 downto 0) is
            when "0001" =>
            led(3 downto 0) <= "0010";
            when "0010" =>
            led(3 downto 0) <= "0100";
            when "0011" =>
            led(3 downto 0) <= "0110";
            when "0111" =>
            led(3 downto 0) <= "1000";
            when "1000" =>
            led(3 downto 0) <= "1010";
            when "1001" =>
            led(3 downto 0) <= "1100";
            when "1010" =>
            led(3 downto 0) <= "1110";
            when others =>
            led(3 downto 0) <= "0000";
        end case;
    end process;
end rtl;