library IEEE;
use ieee.std_logic_1164.all;

entity lab2_task6_tb is
end lab2_task6_tb;

architecture rtl of lab2_task6_tb is
signal test_sw_i: std_logic_vector(1 downto 0) := "00";
signal test_led_o: std_logic;
constant DELAY: time := 10 ns;
constant STABLE: time := 2 ns;
begin
  uut: entity work.lab2_task6 port map (
  sw_i => test_sw_i,
  led_o => test_led_o
 );
 stim_proc: process
 begin
    test_sw_i <= "00";
    wait for DELAY;
    wait for STABLE;
    assert(test_led_o = '1')
    report "Input: 00, Expected: 1, Result: " & std_logic'image(test_led_o)
    severity error;
    test_sw_i <= "01";
    wait for DELAY;
    wait for STABLE;
    assert(test_led_o = '1')
    report "Input: 01, Expected: 1, Result: " & std_logic'image(test_led_o)
    severity error;
    test_sw_i <= "10";
    wait for DELAY;
    wait for STABLE;
    assert(test_led_o = '0')
    report "Input: 10, Expected: 0, Result: " & std_logic'image(test_led_o)
    severity error;
    test_sw_i <= "01";
    wait for DELAY;
    wait for STABLE;
    assert(test_led_o = '0')
    report "Input: 01, Expected: 1, Result: " & std_logic'image(test_led_o)
    severity error;
    test_sw_i <= "11";
    wait for DELAY;
    wait for STABLE;
    assert(test_led_o = '1')
    report  "Input: 11, Expected: 1, Result: " & std_logic'image(test_led_o)
    severity error;
    report "Success";
    wait;
 end process;
end rtl;