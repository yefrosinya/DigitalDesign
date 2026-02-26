library IEEE;
use ieee.std_logic_1164.all;

entity Interconnect is
 generic (
  WIDTH : integer := 1;
  DELAY : time := 1 ns
 );
 port (
  bus_i: in std_logic_vector(WIDTH-1 downto 0);
  bus_o: out std_logic_vector(WIDTH-1 downto 0)
 );
end Interconnect;

architecture rtl of Interconnect is 
begin
 GEN_WIRE: for i in 0 to WIDTH-1 generate
  bus_o(i) <= transport bus_i(i) after DELAY;
 end generate;
end rtl;
