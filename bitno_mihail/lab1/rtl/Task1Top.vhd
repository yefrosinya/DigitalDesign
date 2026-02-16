library IEEE;
use ieee.std_logic_1164.all;
entity test_top is
    port (
        led0: out std_logic;
        led1: out std_logic;
        led2: out std_logic;
        led3: out std_logic;
        led4: out std_logic;
        led5: out std_logic;
        led6: out std_logic;
        led7: out std_logic;
        led8: out std_logic;
        led9: out std_logic;
        led10: out std_logic;
        led11: out std_logic;
        led12: out std_logic;
        led13: out std_logic;
        led14: out std_logic;
        led15: out std_logic
        );
end test_top;

architecture rtl of test_top is
begin
    led0 <= '0';
    led1 <= '1';
    led2 <= '0';
    led3 <= '1';
    led4 <= '0';
    led5 <= '1';
    led6 <= '0';
    led7 <= '1';
    led8 <= '0';
    led9 <= '1';
    led10 <= '0';
    led11 <= '1';
    led12 <= '0';
    led13 <= '1';
    led14 <= '0';
    led15 <= '1';
end rtl;