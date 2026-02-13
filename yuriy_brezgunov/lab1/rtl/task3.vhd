library ieee;
use ieee.std_logic_1164.all;

-- i = E2 = 1110 0010
-- AND      100* **0*
-- j = 80 = 1000 0000
-- sw[7:0] = 100* **0*

entity task3 is
    port (
        led : out std_logic_vector(15 downto 0);
        sw: in std_logic_vector(7 downto 0)
    );
end task3;

architecture rtl of task3 is
begin 
    led(15 downto 8) <= X"00";
    led(7 downto 0) <= X"E2" and sw; 
end rtl;