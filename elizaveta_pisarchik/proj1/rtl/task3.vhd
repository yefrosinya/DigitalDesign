library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity task3 is
    port (
        sw_i  : in  std_logic_vector(7 downto 0);  
        led_o : out std_logic_vector(15 downto 0)
    );
end task3;

architecture rtl of task3 is
    constant I : std_logic_vector(7 downto 0) := b"11101001";
    signal   J : std_logic_vector(0 to 7);
begin
    J <= sw_i or I;

    led_o(7 downto 0)   <= J;
    led_o(15 downto 8)  <= J;
end rtl;