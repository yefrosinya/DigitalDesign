library IEEE;
use ieee.std_logic_1164.all;

entity reg_unit is
    generic (N: natural := 34);
    port(
    CLK, RST, EN: in std_logic;
    Din: in std_logic_vector(N-1 downto 0);
    Dout: out std_logic_vector(N-1 downto 0)
    );
end reg_unit;

architecture rtl of reg_unit is
    signal store: std_logic_vector(N-1 downto 0);
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                store <= (others => '0');
            elsif EN = '1' then
                store <= Din;
            end if;
        end if;
    end process;
    Dout <= store;
end rtl;