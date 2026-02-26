library IEEE;
use ieee.std_logic_1164.all;

entity Gate is
 generic (
  GATE_TYPE : string := "AND2";
  DELAY : time := 1 ns
 );
 port (
  X0 : in std_logic; 
  X1 : in std_logic := '0';
  O : out std_logic
 );
end Gate;

architecture rtl of Gate is 
begin
 G_AND2: if GATE_TYPE = "AND2" generate
  O <= X0 and X1 after DELAY;
 end generate;
 G_OR2: if GATE_TYPE = "OR2" generate
  O <= X0 or X1 after DELAY;
 end generate;
 G_XOR2: if GATE_TYPE = "XOR2" generate
  O <= X0 xor X1 after DELAY;
 end generate;
 G_NOT: if GATE_TYPE = "NOT" generate
  O <= not X0 after DELAY;
 end generate;
end rtl;
