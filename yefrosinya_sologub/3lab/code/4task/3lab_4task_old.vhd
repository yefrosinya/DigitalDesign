library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity freq_div_behav is
    generic (K : natural := 10);
    port (
        CLK, RST, EN : in std_logic;
        Q: out std_logic
    );
end freq_div_behav;

architecture rtl of freq_div_behav is
    signal counter: integer range 0 to (K/2)-1 := 0;
    signal store: std_logic := '0';
begin

    proc: process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                store <= '0';
                counter <= 0;
            elsif EN = '1' then
                if counter = (K/2)-1 then
                    counter <= 0;
                    store <= not store; -- inv + trigger
                else
                    counter <= counter + 1;
                end if;
            end if;     
        end if;
   end process;
   Q <= store;
end rtl;
