library IEEE;
use ieee.std_logic_1164.all;

entity lab3_task2 is
    port(
    D, CLK, CLR_N: in std_logic;
    Q: out std_logic
    );
end lab3_task2;

architecture rtl of lab3_task2 is
    signal store: std_logic;
begin
    process(CLK, CLR_N)
    begin
        if CLR_N = '0' then
            store <= '0';
        elsif rising_edge(CLK) then
            store <= D;
        end if;
    end process;
    Q <= store;
end rtl;