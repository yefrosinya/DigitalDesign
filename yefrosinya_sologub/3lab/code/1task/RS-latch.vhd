library IEEE;
use ieee.std_logic_1164.all;

entity lab3_task1 is 
port (
    nS, nR: in std_logic;
    Q, nQ: out std_logic
);
end lab3_task1;

architecture Structural of lab3_task1 is
    signal s0, s1 : std_logic;
    
    attribute DONT_TOUCH: string;
    attribute DONT_TOUCH of s0: signal is "TRUE";
    attribute DONT_TOUCH of s1: signal is "TRUE";
    
    component NAND2 port (
        x1,x2 : in std_logic;
        o: out std_logic); 
    end component;
begin
    U1: NAND2 port map (s1, nS, s0);
    U2: NAND2 port map (s0, nR, s1);
    Q <= s0;
    nQ <= s1;
end architecture; 