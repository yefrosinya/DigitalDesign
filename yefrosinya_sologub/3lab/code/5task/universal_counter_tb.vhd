library IEEE;
use ieee.std_logic_1164.all;

entity universal_counter_tb is 
end universal_counter_tb;

architecture rtl of universal_counter_tb is
    constant N_test : natural := 144; 
    constant TEST_VECTOR: std_logic_vector(N_test-1 downto 0) := x"1A2B3C4D5E6F7A8B9CADBECFD1E2F3A4B5C6"; 
    constant N_uut: natural := 16;
    signal CLK_test, EN_test, CLR_test, LOAD_test : std_logic;
    signal MODE_test: std_logic_vector(1 downto 0);
    signal Din_test, Dout_test: std_logic_vector(N_uut-1 downto 0) := (others => '0');

    constant DELAY: time := 20 ns;
begin
    uut: entity work.universal_counter
        generic map ( N => N_uut)
        port map (
            CLK => CLK_test,
            CLR => CLR_test,
            EN => EN_test,
            MODE => MODE_test,
            LOAD => LOAD_test,
            Din => Din_test,
            Dout => Dout_test
        );

    CLK_process : process
    begin
        CLK_test <= '0'; wait for 10 ns;
        CLK_test <= '1'; wait for 10 ns;
    end process;

    stim_proc: process
    begin
        CLR_test <= '1';
        wait for DELAY;
        assert (Dout_test = x"0000") report "Error: Reset failed" severity error;  
        CLR_test <= '0';
        wait for DELAY;

        EN_test   <= '1';
        MODE_test <= "00"; 
        LOAD_test <= '0';

        
        for i in N_test-1 downto 0 loop
            Din_test(0) <= TEST_VECTOR(i);
            wait for 5 ns;
            wait until rising_edge(CLK_test);
        end loop;

        EN_test <= '0';
        CLR_test <= '1';
        wait until rising_edge(CLK_test);
        Din_test <= TEST_VECTOR(15 downto 0);
        LOAD_test <= '1';
        wait for 100 ns;
   
        wait; 
    end process;
    
end rtl;
