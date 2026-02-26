library IEEE;
use ieee.std_logic_1164.all;

entity NOT_gate is
 port (
  X0 : in std_logic;
  O : out std_logic
  ); 
end NOT_gate;

architecture rtl of NOT_gate is
begin
 O <= not X0;
end rtl;