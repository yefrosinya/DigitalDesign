library IEEE;
use ieee.std_logic_1164.all;

entity freq_div_behav_tb is
end freq_div_behav_tb;

architecture rtl of freq_div_behav_tb is
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz
    signal clk_4  : std_logic := '0';
    signal rst_4  : std_logic := '0';
    signal en_4   : std_logic := '0';
    signal q_4    : std_logic;

    signal clk_10 : std_logic := '0';
    signal rst_10 : std_logic := '0';
    signal en_10  : std_logic := '0';
    signal q_10   : std_logic;

    signal clk_100 : std_logic := '0';
    signal rst_100 : std_logic := '0';
    signal en_100  : std_logic := '0';
    signal q_100   : std_logic;

begin

    uut_k4: entity work.freq_div_behav
        generic map (K => 4)
        port map (CLK => clk_4, RST => rst_4, EN => en_4, Q => q_4);

    uut_k10: entity work.freq_div_behav
        generic map (K => 10)
        port map (CLK => clk_10, RST => rst_10, EN => en_10, Q => q_10);

    uut_k100: entity work.freq_div_behav
        generic map (K => 100)
        port map (CLK => clk_100, RST => rst_100, EN => en_100, Q => q_100);

    clk_4   <= not clk_4   after CLK_PERIOD/2;
    clk_10  <= not clk_10  after CLK_PERIOD/2;
    clk_100 <= not clk_100 after CLK_PERIOD/2;

    -- K=4 test: F_Q = F_CLK/4 => period Q = 40 ns
    stim_k4: process
    begin
        rst_4 <= '1'; wait for 25 ns;
        rst_4 <= '0'; wait for 10 ns;
        en_4 <= '1';
        wait for 200 ns; 
        en_4 <= '0';
        wait for 50 ns;
        en_4 <= '1';
        wait for 100 ns;
        rst_4 <= '1'; wait for 20 ns;
        rst_4 <= '0';
        en_4  <= '1';
        wait for 100 ns;
        wait;
    end process;

    -- K=10 test: F_Q = F_CLK/10 => period Q = 100 ns
    stim_k10: process
    begin
        rst_10 <= '1'; wait for 25 ns;
        rst_10 <= '0'; wait for 10 ns;
        en_10 <= '1';
        wait for 500 ns;
        en_10 <= '0';
        wait for 50 ns;
        en_10 <= '1';
        wait for 200 ns;
        wait;
    end process;

    -- K=100 test: F_Q = F_CLK/100 => period Q = 1000 ns
    stim_k100: process
    begin
        rst_100 <= '1'; wait for 25 ns;
        rst_100 <= '0'; wait for 10 ns;
        en_100 <= '1';
        wait for 5000 ns;
        en_100 <= '0';
        wait for 200 ns;
        en_100 <= '1';
        wait for 2000 ns;
        wait;
    end process;
end rtl;
