library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_lab4_task2 is
end tb_lab4_task2;

architecture rtl of tb_lab4_task2 is

	constant CLK_PERIOD: time := 10 ns;
	constant CLK_BEAT: positive := 9;
	constant BLINK_BEAT: positive := 4;
	constant TICK: time := (CLK_BEAT + 1) * CLK_PERIOD;
	constant MARGIN: time := 1 ns;

	signal clk, rst, mode, car_sensor, manual_next: std_logic := '0';
	signal main_red, main_yellow, main_green: std_logic;
	signal sec_red, sec_yellow, sec_green: std_logic;

begin

	uut: entity work.lab4_task2
		generic map (
			CLK_BEAT => CLK_BEAT,
			BLINK_BEAT => BLINK_BEAT
		)
		port map (
			CLK => clk,
			RST => rst,
			MODE => mode,
			CAR_SENSOR => car_sensor,
			MANUAL_NEXT => manual_next,
			MAIN_RED => main_red,
			MAIN_YELLOW => main_yellow,
			MAIN_GREEN => main_green,
			SEC_RED => sec_red,
			SEC_YELLOW => sec_yellow,
			SEC_GREEN => sec_green
		);

	clk <= not clk after CLK_PERIOD / 2;

	stim: process
	begin
		report "TEST 1: Reset" severity note;
		rst <= '1';
		wait for 3 * CLK_PERIOD;
		rst <= '0';
		wait for 3 * CLK_PERIOD;

		assert main_green = '1' report "T1: MAIN_GREEN exp=1" severity error;
		assert main_yellow = '0' report "T1: MAIN_YELLOW exp=0" severity error;
		assert main_red = '0' report "T1: MAIN_RED exp=0" severity error;
		assert sec_green = '0' report "T1: SEC_GREEN exp=0" severity error;
		assert sec_yellow = '0' report "T1: SEC_YELLOW exp=0" severity error;
		assert sec_red = '1' report "T1: SEC_RED exp=1" severity error;

		report "TEST 2: Auto mode full cycle (CAR_SENSOR early)" severity note;
		wait for 4 * TICK + MARGIN;

		assert main_green = '1' report "T2: MAIN_GREEN after 4 ticks exp=1" severity error;
		assert main_red = '0' report "T2: MAIN_RED after 4 ticks exp=0" severity error;
		assert sec_red = '1' report "T2: SEC_RED after 4 ticks exp=1" severity error;

		car_sensor <= '1';
		wait for 1 * TICK + MARGIN;

		assert main_yellow = '0' report "T2 BLINK: MAIN_YELLOW exp=0" severity error;
		assert main_red = '0' report "T2 BLINK: MAIN_RED exp=0" severity error;
		assert sec_green = '0' report "T2 BLINK: SEC_GREEN exp=0" severity error;
		assert sec_yellow = '0' report "T2 BLINK: SEC_YELLOW exp=0" severity error;
		assert sec_red = '1' report "T2 BLINK: SEC_RED exp=1" severity error;

		car_sensor <= '0';

		wait for 3 * TICK + MARGIN;

		assert main_green = '0' report "T2 YELLOW: MAIN_GREEN exp=0" severity error;
		assert main_yellow = '1' report "T2 YELLOW: MAIN_YELLOW exp=1" severity error;
		assert main_red = '0' report "T2 YELLOW: MAIN_RED exp=0" severity error;
		assert sec_green = '0' report "T2 YELLOW: SEC_GREEN exp=0" severity error;
		assert sec_yellow = '0' report "T2 YELLOW: SEC_YELLOW exp=0" severity error;
		assert sec_red = '1' report "T2 YELLOW: SEC_RED exp=1" severity error;
		wait for 2 * TICK + MARGIN;

		assert main_green = '0' report "T2 SEC_GREEN: MAIN_GREEN exp=0" severity error;
		assert main_yellow = '0' report "T2 SEC_GREEN: MAIN_YELLOW exp=0" severity error;
		assert main_red = '1' report "T2 SEC_GREEN: MAIN_RED exp=1" severity error;
		assert sec_green = '1' report "T2 SEC_GREEN: SEC_GREEN exp=1" severity error;
		assert sec_yellow = '0' report "T2 SEC_GREEN: SEC_YELLOW exp=0" severity error;
		assert sec_red = '0' report "T2 SEC_GREEN: SEC_RED exp=0" severity error;

		wait for 3 * TICK + MARGIN;

		assert main_green = '0' report "T2 SEC_YELLOW: MAIN_GREEN exp=0" severity error;
		assert main_yellow = '0' report "T2 SEC_YELLOW: MAIN_YELLOW exp=0" severity error;
		assert main_red = '1' report "T2 SEC_YELLOW: MAIN_RED exp=1" severity error;
		assert sec_green = '0' report "T2 SEC_YELLOW: SEC_GREEN exp=0" severity error;
		assert sec_yellow = '1' report "T2 SEC_YELLOW: SEC_YELLOW exp=1" severity error;
		assert sec_red = '0' report "T2 SEC_YELLOW: SEC_RED exp=0" severity error;

		wait for 2 * TICK + MARGIN;

		assert main_green = '1' report "T2 back MAIN_GREEN: MAIN_GREEN exp=1" severity error;
		assert main_yellow = '0' report "T2 back MAIN_GREEN: MAIN_YELLOW exp=0" severity error;
		assert main_red = '0' report "T2 back MAIN_GREEN: MAIN_RED exp=0" severity error;
		assert sec_red = '1' report "T2 back MAIN_GREEN: SEC_RED exp=1" severity error;

		report "TEST 3: SEC_GREEN extended by CAR_SENSOR" severity note;

		car_sensor <= '1';
		wait for 1 * TICK + MARGIN;
		wait for 3 * TICK + MARGIN;
		wait for 2 * TICK + MARGIN;

		assert sec_green = '1' report "T3: SEC_GREEN entry exp=1" severity error;
		assert main_red = '1' report "T3: MAIN_RED entry exp=1" severity error;

		wait for 3 * TICK + MARGIN;

		assert sec_green = '1' report "T3: SEC_GREEN at 3 ticks still exp=1" severity error;

		wait for 3 * TICK + MARGIN;

		assert sec_green = '0' report "T3: SEC_GREEN after 6 ticks exp=0" severity error;
		assert sec_yellow = '1' report "T3: SEC_YELLOW after 6 ticks exp=1" severity error;

		car_sensor <= '0';
		wait for 2 * TICK + MARGIN;

		assert main_green = '1' report "T3: MAIN_GREEN after extended cycle exp=1" severity error;
		assert sec_red = '1' report "T3: SEC_RED after extended cycle exp=1" severity error;

		report "TEST 4: MAIN_GREEN 10-second timeout" severity note;

		wait for 9 * TICK + MARGIN;

		assert main_green = '1' report "T4: MAIN_GREEN at 9 ticks still exp=1" severity error;

		wait for 1 * TICK + MARGIN;

		assert main_yellow = '0' report "T4: should be BLINK, MAIN_YELLOW exp=0" severity error;
		assert main_red = '0' report "T4: should be BLINK, MAIN_RED exp=0" severity error;
		assert sec_red = '1' report "T4: should be BLINK, SEC_RED exp=1" severity error;

		wait for 3 * TICK + MARGIN;
		wait for 2 * TICK + MARGIN;
		wait for 3 * TICK + MARGIN;
		wait for 2 * TICK + MARGIN;

		assert main_green = '1' report "T4: MAIN_GREEN after timeout cycle exp=1" severity error;

		report "TEST 5: Manual mode" severity note;

		mode <= '1';
		wait for 1 * TICK + MARGIN;
		wait for MARGIN;

		assert main_green = '1' report "T5: Manual MAIN_GREEN exp=1" severity error;
		assert sec_red = '1' report "T5: Manual SEC_RED exp=1" severity error;

		manual_next <= '1';
		wait for 3 * CLK_PERIOD;
		manual_next <= '0';
		wait for 3 * CLK_PERIOD;

		assert main_green = '0' report "T5: Manual MAIN_YELLOW: MAIN_GREEN exp=0" severity error;
		assert main_yellow = '1' report "T5: Manual MAIN_YELLOW: MAIN_YELLOW exp=1" severity error;
		assert main_red = '0' report "T5: Manual MAIN_YELLOW: MAIN_RED exp=0" severity error;
		assert sec_red = '1' report "T5: Manual MAIN_YELLOW: SEC_RED exp=1" severity error;

		manual_next <= '1';
		wait for 3 * CLK_PERIOD;
		manual_next <= '0';
		wait for 3 * CLK_PERIOD;

		assert main_yellow = '0' report "T5: Manual SEC_GREEN: MAIN_YELLOW exp=0" severity error;
		assert main_red = '1' report "T5: Manual SEC_GREEN: MAIN_RED exp=1" severity error;
		assert sec_green = '1' report "T5: Manual SEC_GREEN: SEC_GREEN exp=1" severity error;
		assert sec_red = '0' report "T5: Manual SEC_GREEN: SEC_RED exp=0" severity error;

		manual_next <= '1';
		wait for 3 * CLK_PERIOD;
		manual_next <= '0';
		wait for 3 * CLK_PERIOD;

		assert sec_green = '0' report "T5: Manual SEC_YELLOW: SEC_GREEN exp=0" severity error;
		assert sec_yellow = '1' report "T5: Manual SEC_YELLOW: SEC_YELLOW exp=1" severity error;
		assert main_red = '1' report "T5: Manual SEC_YELLOW: MAIN_RED exp=1" severity error;

		manual_next <= '1';
		wait for 3 * CLK_PERIOD;
		manual_next <= '0';
		wait for 3 * CLK_PERIOD;

		assert main_green = '1' report "T5: Manual back MAIN_GREEN exp=1" severity error;
		assert sec_red = '1' report "T5: Manual back SEC_RED exp=1" severity error;

		manual_next <= '1';
		wait for 3 * CLK_PERIOD;
		manual_next <= '0';
		wait for 3 * CLK_PERIOD;
		assert main_yellow = '1' report "T5: Manual cycle2 MAIN_YELLOW exp=1" severity error;

		manual_next <= '1';
		wait for 3 * CLK_PERIOD;
		manual_next <= '0';
		wait for 3 * CLK_PERIOD;
		assert sec_green = '1' report "T5: Manual cycle2 SEC_GREEN exp=1" severity error;

		manual_next <= '1';
		wait for 3 * CLK_PERIOD;
		manual_next <= '0';
		wait for 3 * CLK_PERIOD;
		assert sec_yellow = '1' report "T5: Manual cycle2 SEC_YELLOW exp=1" severity error;

		manual_next <= '1';
		wait for 3 * CLK_PERIOD;
		manual_next <= '0';
		wait for 3 * CLK_PERIOD;
		assert main_green = '1' report "T5: Manual cycle2 MAIN_GREEN exp=1" severity error;

		report "TEST 6: Return to auto mode" severity note;

		mode <= '0';
		wait for 1 * TICK + MARGIN;
		wait for MARGIN;
		car_sensor <= '1';
		wait for 1 * TICK + MARGIN;

		assert main_red = '0' report "T6: Return auto BLINK: MAIN_RED exp=0" severity error;
		assert sec_red = '1' report "T6: Return auto BLINK: SEC_RED exp=1" severity error;

		car_sensor <= '0';

		wait for 3 * TICK + MARGIN;
		assert main_yellow = '1' report "T6: Return auto MAIN_YELLOW exp=1" severity error;

		wait for 2 * TICK + MARGIN;
		wait for 3 * TICK + MARGIN;
		wait for 2 * TICK + MARGIN;

		assert main_green = '1' report "T6: Return auto MAIN_GREEN exp=1" severity error;

		report "TEST 7: RST during SEC_GREEN" severity note;

		car_sensor <= '1';
		wait for 1 * TICK + MARGIN;
		wait for 3 * TICK + MARGIN;
		wait for 2 * TICK + MARGIN;

		assert sec_green = '1' report "T7: Before RST SEC_GREEN exp=1" severity error;
		assert main_red = '1' report "T7: Before RST MAIN_RED exp=1" severity error;
		car_sensor <= '0';
		rst <= '1';
		wait for 3 * CLK_PERIOD;
		rst <= '0';
		wait for 3 * CLK_PERIOD;

		assert main_green = '1' report "T7: After RST MAIN_GREEN exp=1" severity error;
		assert sec_red = '1' report "T7: After RST SEC_RED exp=1" severity error;
		assert main_red = '0' report "T7: After RST MAIN_RED exp=0" severity error;

		report "TEST 8: SEC_GREEN early exit" severity note;

		car_sensor <= '1';
		wait for 1 * TICK + MARGIN;
		wait for 3 * TICK + MARGIN;
		wait for 2 * TICK + MARGIN;

		assert sec_green = '1' report "T8: SEC_GREEN with CAR exp=1" severity error;

		wait for 2 * TICK;
		car_sensor <= '0';
		wait for 1 * TICK + MARGIN;

		assert sec_yellow = '1' report "T8: SEC_YELLOW after early exit exp=1" severity error;
		assert sec_green = '0' report "T8: SEC_GREEN after early exit exp=0" severity error;

		wait for 2 * TICK + MARGIN;

		assert main_green = '1' report "T8: MAIN_GREEN after early exit cycle exp=1" severity error;

		report "=== ALL TESTS PASSED ===" severity note;
		wait;
	end process;

end rtl;