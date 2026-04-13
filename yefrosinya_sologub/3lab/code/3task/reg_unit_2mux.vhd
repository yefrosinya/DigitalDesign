library IEEE;
use ieee.std_logic_1164.all;

entity reg_unit is
    generic (N: natural := 34);
    port(
    CLK, RST, EN: in std_logic;
    Din: in std_logic_vector(N-1 downto 0);
    Dout: out std_logic_vector(N-1 downto 0)
    );
end reg_unit;

architecture Structural of reg_unit is
    signal store: std_logic_vector(N-1 downto 0);
    signal bit_in: std_logic_vector(N-1 downto 0);
    signal clear_n: std_logic;
    component lab3_task2  port (
        D, CLK, CLR_N: in std_logic;
        Q: out std_logic
    );
    end component;

begin
    
    triggers: for i in 0 to N-1 generate
        bit_in(i) <= '0' when RST = '1' else Din(i) when EN = '1' else store(i);
        trig: lab3_task2 port map (
            CLK => CLK,
            D => bit_in(i),
            CLR_N => '1',
            Q => store(i)
        );
    end generate;
    Dout <= store;
end Structural;
