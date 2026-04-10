library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_2r1w_tb is
end reg_file_2r1w_tb;

architecture rtl of reg_file_2r1w_tb is
     constant ADDR_WIDTH_test: natural := 5;
   constant DATA_WIDTH_test: natural := 16;
   constant CLK_PERIOD: time := 10 ns;

   signal clk: std_logic := '0';
   signal clr: std_logic := '0';
   signal w_en: std_logic := '0';
   signal w_addr: std_logic_vector(ADDR_WIDTH_test-1 downto 0) := (others => '0');
   signal w_data: std_logic_vector(DATA_WIDTH_test-1 downto 0) := (others => '0');
   signal r_addr_0: std_logic_vector(ADDR_WIDTH_test-1 downto 0) := (others => '0');
   signal r_data_0: std_logic_vector(DATA_WIDTH_test-1 downto 0);
   signal r_addr_1: std_logic_vector(ADDR_WIDTH_test-1 downto 0) := (others => '0');
   signal r_data_1: std_logic_vector(DATA_WIDTH_test-1 downto 0);

begin

   uut: entity work.reg_file_2r1w
       generic map ( ADDR_WIDTH => ADDR_WIDTH_test, DATA_WIDTH => DATA_WIDTH_test )
       port map (
           CLK => clk, CLR => clr, W_EN => w_en,
           W_ADDR => w_addr, W_DATA => w_data,
           R_ADDR_0 => r_addr_0, R_DATA_0 => r_data_0,
           R_ADDR_1 => r_addr_1, R_DATA_1 => r_data_1
       );

   clk <= not clk after CLK_PERIOD / 2;

   stim_proc: process
   begin
       clr <= '1'; wait for 25 ns;
       clr <= '0'; wait for CLK_PERIOD;
       r_addr_0 <= "00000"; r_addr_1 <= "00001";
       wait for 1 ns;
       assert (r_data_0 = x"0000") report "Reset failed for Reg0" severity error;
       assert (r_data_1 = x"0000") report "Reset failed for Reg1" severity error;

       w_en <= '1';
       w_addr <= "00000"; w_data <= x"AAAA"; wait for CLK_PERIOD;
       w_addr <= "00001"; w_data <= x"BBBB"; wait for CLK_PERIOD;
       w_addr <= "00010"; w_data <= x"CCCC"; wait for CLK_PERIOD;
       w_en <= '0';

       r_addr_0 <= "00000"; r_addr_1 <= "00001";
       wait for CLK_PERIOD;
       assert (r_data_0 = x"AAAA") report "Read Reg0 mismatch!" severity error;
       assert (r_data_1 = x"BBBB") report "Read Reg1 mismatch!" severity error;

       r_addr_0 <= "00010"; r_addr_1 <= "00000";
       wait for CLK_PERIOD;
       assert (r_data_0 = x"CCCC") report "Read Reg2 mismatch!" severity error;
       assert (r_data_1 = x"AAAA") report "Read Reg0 (Port1) mismatch!" severity error;

       w_en <= '1'; w_addr <= "00101"; w_data <= x"1234";
       r_addr_0 <= "00101"; 
       wait for 2 ns;
       assert (r_data_0 = x"1234") report "Forwarding failed!" severity error;
       wait for CLK_PERIOD - 2 ns;
       w_en <= '0';
       w_en <= '0'; w_addr <= "00000"; w_data <= x"FFFF";
       r_addr_0 <= "00000";
       wait for CLK_PERIOD;
       assert (r_data_0 = x"AAAA") report "Write occurred while W_EN was LOW!" severity error;

       clr <= '1'; wait for CLK_PERIOD;
       clr <= '0'; wait for CLK_PERIOD;
       r_addr_0 <= "00101"; 
       wait for 1 ns;
       assert (r_data_0 = x"0000") report "Final reset failed!" severity error;

       wait;
   end process;
end rtl;