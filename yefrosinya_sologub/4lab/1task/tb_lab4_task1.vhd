library ieee;
use ieee.std_logic_1164.all;

entity tb_lab4_task1 is
end tb_lab4_task1;

architecture rtl of tb_lab4_task1 is
    signal clk: std_logic := '0';
    signal rst: std_logic := '0';
    signal en: std_logic := '0';
    signal q: std_logic_vector(2 downto 0);
begin
    uut: entity work.lab4_task1 port map (clk, rst, en, q);

    clk <= not clk after 10 ns;

    process
    begin
        rst <= '1'; wait for 30 ns;
        rst <= '0'; wait for 20 ns;
        en <= '1'; wait for 250 ns;
        en <= '0'; wait for 50 ns;
        en <= '1'; wait for 250 ns; 
        wait;
    end process;
end rtl;