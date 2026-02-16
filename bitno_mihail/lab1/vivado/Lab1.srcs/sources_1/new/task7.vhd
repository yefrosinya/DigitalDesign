library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity task7 is
    port (
        led : out std_logic_vector(3 downto 0); -- led3 = c3, led2 = c2, led1 = c1, led0 = c0
        sw: in std_logic_vector(15 downto 12) -- x3, x2, x1, x0
    );
end task7;


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



-- G = 8421 = x3x2x1x0
-- L = 7210 = c3c2c1c0

-- c3 = x3 or x2
-- c2 = !x2 and (x3 or x1)
-- c1 = !x2 and (x3 xor x0)
-- c0 = 0


-- INV COMPONENT
entity inv is
    Port ( i : in STD_LOGIC; o : out STD_LOGIC);
end inv;

architecture behave of inv is
begin
    o <= not i;
end behave;

architecture rtl of task7 is
    component inv 
        Port (i: in std_logic; o: out std_logic);
    end component;
    
    component mux2 
        Port (i0, i1, s: in std_logic; o: out std_logic);
    end component;
    
    signal not_x2, not_x3: std_logic;
    signal x3_or_x1, x3_xor_x0: std_logic;
    signal c3, c2, c1, c0: std_logic;
    signal c0_conj1_p1, c0_conj1_p2, c0_conj2_p1, c0_conj2_p2, c0_conj2_p3, c0_res: std_logic;
begin 
    INV_X2: INV port map (I => sw(14), O => not_x2);
    INV_X3: INV port map (I => sw(15), O => not_x3);
    
    MUX2_OR_X3_X1: MUX2 port map (I0 => sw(15), I1 => '1', S => sw(13), O => x3_or_x1);
    MUX2_XOR_X3_X0: MUX2 port map (I0 => sw(15), I1 => not_x3, S => sw(12), O => x3_xor_x0);
    
    --C3
    MUX2_OR_X3_X2: MUX2 port map (I0 => sw(15), I1 => '1', S => sw(14), O => led(3));
    
    -- C2 = !x2 and (x3 or x1)
    MUX2_C2: MUX2 port map (I0 => '0', I1 => not_x2, S => x3_or_x1, O => led(2));
    -- C1 = !x2 and (x3 xor x0)
    MUX2_C1: MUX2 port map (I0 => '0', I1 => not_x2, S => x3_xor_x0, O => led(1));
    -- C0
    led(0) <= '0';
end rtl;


