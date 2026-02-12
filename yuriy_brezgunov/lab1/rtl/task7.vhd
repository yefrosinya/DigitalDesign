library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- G = 7421
-- L = Áåğãåğà (êîëè÷åñòâî 1)

-- c1 = (x3 xor x2)(x1 xor x0) + ¬x3¬x2x1x0
-- c0 = (x3 xor x2) ¬x1¬x0 + ¬x3¬x2(x1 xor x0)

entity task7 is
    port (
        led : out std_logic_vector(15 downto 10); -- led11 = c1, led10 = c0
        sw: in std_logic_vector(15 downto 12) -- x3, x2, x1, x0
    );
end task7;


architecture rtl of task7 is
    component inv 
        Port (i: in std_logic; o: out std_logic);
    end component;
    
    component mux2 
        Port (i0, i1, s: in std_logic; o: out std_logic);
    end component;
    
    signal not_x0, not_x1, not_x2, not_x3: std_logic;
    signal x3_xor_x2, x1_xor_x0: std_logic;
    signal c1_conj1, c1_conj2_p1, c1_conj2_p2, c1_conj2_p3, c1_res: std_logic;
    signal c0_conj1_p1, c0_conj1_p2, c0_conj2_p1, c0_conj2_p2, c0_conj2_p3, c0_res: std_logic;
begin 
    INV_X0: INV port map (I => sw(12), O => not_x0);
    INV_X1: INV port map (I => sw(13), O => not_x1);
    INV_X2: INV port map (I => sw(14), O => not_x2);
    INV_X3: INV port map (I => sw(15), O => not_x3);
    
    MUX2_XOR_X2_X3: MUX2 port map (I0 => sw(15), I1 => not_x3, S => sw(14), O => x3_xor_x2);
    MUX2_XOR_X1_X0: MUX2 port map (I0 => sw(13), I1 => not_x1, S => sw(12), O => x1_xor_x0);
    
    -- Calculate C1
    -- C1 = (x3 xor x2)(x1 xor x0) + ¬x3¬x2x1x0
    MUX2_AND_C1_11: MUX2 port map (I0 => '0', I1 => x3_xor_x2, S => x1_xor_x0, O => c1_conj1);
    
    MUX2_AND_C1_21: MUX2 port map (I0 => '0', I1 => not_x3, S => not_x2, O => c1_conj2_p1);
    MUX2_AND_C1_22: MUX2 port map (I0 => '0', I1 => sw(13), S => c1_conj2_p1, O => c1_conj2_p2);
    MUX2_AND_C1_23: MUX2 port map (I0 => '0', I1 => sw(12), S => c1_conj2_p2, O => c1_conj2_p3);
    
    MUX2_OR_C1: MUX2 port map (I0 => c1_conj2_p3, I1 => '1', S => c1_conj1, O => c1_res);
    
    led(11) <= c1_res;
    
    -- Calculate C0
    -- c0 = (x3 xor x2) ¬x1¬x0 + ¬x3¬x2(x1 xor x0)
    MUX2_AND_C0_11: MUX2 port map (I0 => x3_xor_x2, I1 => '0', S => not_x1, O => c0_conj1_p1);
    MUX2_AND_C0_12: MUX2 port map (I0 => c0_conj1_p1, I1 => '0', S => not_x0, O => c0_conj1_p2);
        
    MUX2_AND_C0_21: MUX2 port map (I0 => '0', I1 => not_x3, S => not_x2, O => c0_conj2_p1);
    MUX2_AND_C0_22: MUX2 port map (I0 => '0', I1 => x1_xor_x0, S => c0_conj2_p1, O => c0_conj2_p2);
    
    MUX2_OR_C2: MUX2 port map (I0 => c0_conj1_p1, I1 => '1', S => c0_conj2_p2, O => c0_res);
    
    led(10) <= c0_res;
    
    led(15 downto 12) <= sw;
end rtl;



-- MUX 2 COMPONENT
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( 
        s, i0, i1 : in STD_LOGIC; 
        o : out STD_LOGIC
    );
end mux2;

architecture behave of mux2 is
begin
    o <= i0 when s = '0' else i1;
end behave;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



-- INV COMPONENT
entity inv is
    Port ( i : in STD_LOGIC; o : out STD_LOGIC);
end inv;

architecture behave of inv is
begin
    o <= not i;
end behave;