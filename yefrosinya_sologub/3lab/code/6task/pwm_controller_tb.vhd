library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_controller_tb is
end pwm_controller_tb;

architecture rtl of pwm_controller_tb is
    constant CNT_WIDTH_test: natural := 4;
    signal CLK_test: std_logic := '0';
    signal CLR_test: std_logic := '0';
    signal EN_test: std_logic := '0';
    signal Q_test: std_logic;
    signal FILL_test: std_logic_vector(CNT_WIDTH_test-1 downto 0) := (others => '0');
begin
uut: entity work.pwm_controller
    generic map (CNT_WIDTH => CNT_WIDTH_test)
    port map (
        CLK => CLK_test, 
        CLR => CLR_test, 
        EN => EN_test, 
        Q => Q_test, 
        FILL => FILL_test);
    CLK_process: process
    begin
        CLK_test <= '0'; wait for 10 ns;
        CLK_test <= '1'; wait for 10 ns;
    end process;
    stim_proc: process
    begin
        CLR_test <= '1'; wait for 40 ns;
        CLR_test <= '0'; EN_test <= '1'; wait for 40 ns;
        -- 0%
        FILL_test <= x"0"; wait for 1 us;
        -- 25% (4/16)
        FILL_test <= x"4"; wait for 1 us;
        -- 50% (8/16)
        FILL_test <= x"8"; wait for 1 us;
        -- 75% (12/16)
        FILL_test <= x"C"; wait for 1 us;
        -- 100% (16/16)
        FILL_test <= x"F"; wait for 1 us;

        FILL_test <= x"2"; wait for 1 us;
        FILL_test <= x"A"; wait for 1 us;

        EN_test <= '0'; wait for 1 us;
        EN_test <= '1'; wait for 1 us;
        CLR_test <= '1'; wait for 100 ns;
        CLR_test <= '0'; wait;
    end process;
end rtl;