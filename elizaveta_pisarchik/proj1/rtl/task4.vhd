library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity task4 is
    port (
        sw_i  : in  std_logic_vector(15 downto 0);
        led_o : out std_logic_vector(15 downto 0)
    );
end task4;

architecture rtl of task4 is
    signal x0, x1, x2, x3, nx0, nx1, nx2, nx3 : std_logic;
begin
    x0 <= sw_i(0);
    x1 <= sw_i(1);
    x2 <= sw_i(2);
    x3 <= sw_i(3);

    nx0 <= not x0;
    nx1 <= not x1;
    nx2 <= not x2;
    nx3 <= not x3;

    led_o(0) <= (nx3 and nx2) or (x2 and nx1 and nx0) or (nx3 and x1 and x0) or (nx2 and x1 and nx0);
end rtl;