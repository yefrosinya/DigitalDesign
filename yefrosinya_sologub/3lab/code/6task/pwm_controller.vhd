library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_controller is 
    generic (CNT_WIDTH: natural := 8);
    port (
        CLK, CLR, EN: in std_logic;
        Q: out std_logic;
        FILL: in std_logic_vector(CNT_WIDTH-1 downto 0) -- duty cycle
    );
end pwm_controller;

architecture rtl of pwm_controller is
    signal store: std_logic;
    signal counter: natural range 0 to (2**CNT_WIDTH) - 1 := 0; -- max degree 31
    signal fill_natural: natural;
begin
    fill_natural <= to_integer(unsigned(FILL));
    
    proc: process(CLK, CLR)
    begin   
        if CLR = '1' then
            store <= '0';
            counter <= 0;
        elsif rising_edge(CLK) then
            if (counter = (2**CNT_WIDTH - 1)) then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
            if EN = '1' then
                if counter < fill_natural then
                    store <= '1';
                else
                    store <= '0';
                end if;
            else
                store <= '0';
            end if;
        end if;
    end process;
    Q <= store;
end rtl;
