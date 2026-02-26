library IEEE;
use ieee.std_logic_1164.all;

entity lab2_task3_tb is
end lab2_task3_tb;

architecture rtl of lab2_task3_tb is
 signal test_sw_i : std_logic_vector (3 downto 0);
 signal test_led_o : std_logic_vector (3 downto 0);
 constant DELAY: time := 20 ns;
begin
 uut: entity work.lab2_task3 port map (
  sw_i => test_sw_i,
  led_o => test_led_o
 );
 
 stim_proc: process
 begin
  test_sw_i <= "0000";
  wait for DELAY;
  assert (test_led_o = "0000")
   report "Error. Input: 0000"
   severity error;
  
  test_sw_i <= "0001";
  wait for DELAY;
  assert (test_led_o = "0001")
   report "Error. Input: 0001"
   severity error;
  
  test_sw_i <= "0011";
  wait for DELAY;
  assert (test_led_o = "0010")
   report "Error. Input: 0011"
   severity error;
   
  test_sw_i <= "0010";
  wait for DELAY;
  assert (test_led_o = "0011")
   report "Error. Input: 0010"
   severity error;
   
  test_sw_i <= "0110";
  wait for DELAY;
  assert (test_led_o = "0100")
   report "Error. Input: 0110"
   severity error;
  
  test_sw_i <= "0111";
  wait for DELAY;
  assert (test_led_o = "1000")
   report "Error. Input: 0111"
   severity error;
   
  test_sw_i <= "0101";
  wait for DELAY;
  assert (test_led_o = "1001")
   report "Error. Input: 0101"
   severity error;
  
  test_sw_i <= "0100";
  wait for DELAY;
  assert (test_led_o = "1010")
   report "Error. Input: 0100"
   severity error;
  
  test_sw_i <= "1100";
  wait for DELAY;
  assert (test_led_o = "1011")
   report "Error. Input: 1100"
   severity error;
  
  test_sw_i <= "1101";
  wait for DELAY;
  assert (test_led_o = "1100")
   report "Error. Input: 1101"
   severity error;
  
  report "Success"; 
  wait;
 end process;
end rtl;
