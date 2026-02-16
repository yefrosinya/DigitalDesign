library ieee;
use ieee.std_logic_1164.all;

entity Task4 is
port (
    sw : in std_logic_vector(15 downto 0);
    led : out std_logic_vector(15 downto 0)
);
end Task4;

architecture rtl of Task4 is
    signal n_sw0, n_sw1, n_sw2 : std_logic;
    signal term1, term2, term3, term4 : std_logic;
    signal f_result : std_logic;
begin
    n_sw0 <= not sw(0);
    n_sw1 <= not sw(1);
    n_sw2 <= not sw(2);
    
    term1 <= sw(1) and sw(3);
    term2 <= n_sw0 and sw(3);
    term3 <= sw(0) and n_sw2 and sw(3);
    term4 <= n_sw0 and n_sw1 and sw(2);
    
    f_result <= term1 or term2 or term3 or term4;
    
    led(0) <= f_result;
    led(15 downto 1) <= (others => '0');
end rtl;