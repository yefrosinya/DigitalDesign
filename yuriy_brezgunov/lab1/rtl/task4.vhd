library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.VComponents.all;

entity task4 is
    port (
        sw  : in  STD_LOGIC_VECTOR (3 downto 0); -- A=3, B=2, C=1, D=0
        led : out STD_LOGIC_VECTOR (0 downto 0)
    );
end task4;

-- F = ¬A¬B(C or D) + ¬CD + AB(C nand D) + ¬AB¬C

architecture rtl of task4 is
    signal not_a, not_b, not_c : std_logic;
    signal c_or_d, c_nand_d: std_logic;
    signal conj1, conj2, conj3, conj4: std_logic;
    signal res: std_logic;
begin 
    INV_A: INV port map (I => sw(3), O => not_a);
    INV_B: INV port map (I => sw(2), O => not_b);
    INV_C: INV port map (I => sw(1), O => not_c);
    
    OR_C_D: OR2 port map (I0 => sw(1), I1 => sw(0), O => c_or_d);
    NAND_C_D: NAND2 port map (I0 => sw(1), I1 => sw(0), O => c_nand_d);
    
    AND_CONJ1: AND3 port map (I0 => not_a, I1 => not_b, I2 => c_or_d, O => conj1);
    AND_CONJ2: AND2 port map (I0 => not_c, I1 => sw(0), O => conj2);
    AND_CONJ3: AND3 port map (I0 => sw(3), I1 => sw(2), I2 => c_nand_d, O => conj3);
    AND_CONJ4: AND3 port map (I0 => not_a, I1 => sw(2), I2 => not_c, O => conj4);
    
    OR_RES: OR4 port map (I0 => conj1, I1 => conj2, I2 => conj3, I3 => conj4, O => res);
    
    led(0) <= res;
end rtl;
