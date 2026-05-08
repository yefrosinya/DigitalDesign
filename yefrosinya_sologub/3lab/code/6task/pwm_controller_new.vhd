library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_sid.all;

entity pwm_controller is
    generic (CNT_WIDTH: natural := 8); 
    port (
        CLK, CLR, EN: in std_logic;
        Q: out std_logic;
        FILL: in std_logic_vector(CNT_WIDTH-1 downto 0) -- duty cycle
    );
end pwm_controller;

architecture rtl of pwm_controller is
    signal counter: unsigned(CNT_WIDTH-1) := 0; 
begin

    process(CLK, CLR)
    begin
        if CLR = '1' then
            counter <= (others => '0');
        elsif rising_edge(CLK) then
            if EN = '1' then
                counter <= counter + 1; 
            end if;
        end if;
    end process;

    Q <= '1' when (counter < unsigned(FILL)) else '0';
end rtl;
