library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity task6 is
    port (
        led : out std_logic_vector(15 downto 9);
        sw: in std_logic_vector(15 downto 12) -- b3, b2, b1, b0
    );
end task6;

-- G = 7421
-- L = Бергера (количество 1)

architecture rtl of task6 is
    signal b0, b1, b2, b3: std_logic_vector(2 downto 0);
    signal zeros_sum: std_logic_vector(2 downto 0);
begin 
    b3 <= "001" when sw(15) = '1' else "000";
    b2 <= "001" when sw(14) = '1' else "000";
    b1 <= "001" when sw(13) = '1' else "000";
    b0 <= "001" when sw(12) = '1' else "000";
    
    led(11 downto 9) <= b0 + b1 +  b2 + b3;
    led(15 downto 12) <= sw;
end rtl;