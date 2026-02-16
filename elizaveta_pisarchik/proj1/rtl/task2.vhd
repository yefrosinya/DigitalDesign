library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity task2 is
    port (
        sw_i  : in  std_logic_vector(0 to 13);
        led_o : out std_logic_vector(0 to 13)
    );
end task2;

architecture rtl of task2 is
begin
  led_o <= sw_i;
end rtl;