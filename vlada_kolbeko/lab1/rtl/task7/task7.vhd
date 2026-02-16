library ieee;
use ieee.std_logic_1164.all;

-- Task 7
-- Input code - Berger Code (4 bit, 2 bits sw_i(1:0) - data, 2 bits sw_i(3:2) - control)
-- Output code - 6321 (4 bits led_o(3:0))
-- Minimized Y1 = 0
-- Minimized Y2 = (not X3) and (not X4)
-- Minimized Y3 = X1 and (not X2)
-- Minimized Y4 = X2 and X4

entity min_code_conv is
    port (
        sw_i    : in    std_logic_vector(15 downto 0);
        led_o   : out   std_logic_vector(15 downto 0)
    );
end min_code_conv;

architecture structural of min_code_conv is
    signal nX2, nX3, nX4    :   std_logic;
    
    component INV
        port (
            X   : in    std_logic;
            Y   : out   std_logic
        );
    end component; 
    
    component MUX2
        port (
            X1  : in    std_logic;
            X2  : in    std_logic;
            S   : in    std_logic;   
            Y   : out   std_logic
        );
    end component; 
begin
    INV0: INV   port map (
        X => sw_i(1),
        Y => nX2
    );    
    INV1: INV   port map (
        X => sw_i(2),
        Y => nX3
    );
    INV2: INV   port map (
        X => sw_i(3),
        Y => nX4
    );
       
    MUX2_0: MUX2    port map (
        X1 => '0',
        X2 => nX4,
        S => nX3,
        Y => led_o(2)
    ); 
    MUX2_1: MUX2    port map (
        X1 => '0',
        X2 => nX2,
        S => sw_i(0),
        Y => led_o(1)
    ); 
    MUX2_2: MUX2    port map (
        X1 => '0',
        X2 => sw_i(3),
        S => sw_i(1),
        Y => led_o(0)
    );
    
    led_o(3) <= '0';
    led_o(15 downto 4) <= (others => '0');  
end structural;