library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity task5 is
    port (
        sw_i  : in  std_logic_vector(15 downto 0);
        led_o : out std_logic_vector(15 downto 0)
    );
end task5;

architecture rtl of task5 is
    signal sA, sB, sC, sD : std_logic;
    signal x, y : std_logic_vector(5 downto 0);
    signal rA, rB, rC, rD : std_logic_vector(5 downto 0);
begin
    x <= sw_i(15 downto 10);
    y <= sw_i(9 downto 4);

    sA <= sw_i(0);
    sB <= sw_i(1);
    sC <= sw_i(2);
    sD <= sw_i(3);

    rA <= not (x or y);
    rB <= x or y; --точно????
    rC <= x(2 downto 0) & "000";
    rD <= x and y;

    led_o(0) <= (sA and rA(0)) or (sB and rB(0)) or (sC and rC(0)) or (sD and rD(0));
    led_o(1) <= (sA and rA(1)) or (sB and rB(1)) or (sC and rC(1)) or (sD and rD(1));
    led_o(2) <= (sA and rA(2)) or (sB and rB(2)) or (sC and rC(2)) or (sD and rD(2));
    led_o(3) <= (sA and rA(3)) or (sB and rB(3)) or (sC and rC(3)) or (sD and rD(3));
    led_o(4) <= (sA and rA(4)) or (sB and rB(4)) or (sC and rC(4)) or (sD and rD(4));
    led_o(5) <= (sA and rA(5)) or (sB and rB(5)) or (sC and rC(5)) or (sD and rD(5));

    led_o(15 downto 6) <= sw_i(15 downto 6);
end rtl;