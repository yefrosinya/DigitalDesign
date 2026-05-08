library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        CLK_100MHZ: in  std_logic; 
        RST: in  std_logic; 
        EN: in  std_logic;
        Q: out std_logic_vector(2 downto 0)
    );
end top;

architecture structural of top is
    signal slow_clk: std_logic;
begin
    divisor: entity work.freq_div_behav
        generic map (K => 50000000)
        port map (
            CLK => CLK_100MHZ,
            RST => RST, 
            EN  => '1', 
            Q => slow_clk
        );
    fsm_inst: entity work.lab4_task1
        port map (
            CLK => slow_clk,
            RST => RST,
            EN  => EN,
            Q   => Q
        );

end structural;