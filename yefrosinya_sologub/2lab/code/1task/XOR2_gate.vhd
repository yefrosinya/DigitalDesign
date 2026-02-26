library IEEE;
use ieee.std_logic_1164.all;

entity XOR2_gate is
 port (
  X0, X1 : in std_logic;
  O : out std_logic
  ); 
end XOR2_gate;

architecture rtl of XOR2_gate is
begin
 O <= X1 xor X0;
end rtl;