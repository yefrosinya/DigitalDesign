library IEEE;
use ieee.std_logic_1164.all;

entity universal_counter is 
    generic (N: natural := 16);
    port (
        CLK, CLR, EN, LOAD: in std_logic;
        MODE: in std_logic_vector(1 downto 0);
        Din: in std_logic_vector(N-1 downto 0);
        Dout: out std_logic_vector(N-1 downto 0)    
    );
end universal_counter;

architecture rtl of universal_counter is
    signal store: std_logic_vector(N-1 downto 0);
begin
    
    proc: process(CLK, CLR, MODE)
        variable feedback: std_logic;
    begin
        if CLR = '1' then
            store <= (others => '0');
        elsif rising_edge(CLK)then
            if LOAD = '1' then
                store <= Din;
            elsif EN = '1' then
                case MODE is
                    when "00" =>
                        feedback := store(15) xor store(11) xor store(4) xor Din(0);
                        store <= store(N-2 downto 0) & feedback;
                    when others =>
                        store <= store;
                end case;
            end if;
        end if;
    end process;
    Dout <= store;
end rtl;