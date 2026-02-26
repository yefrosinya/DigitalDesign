library IEEE;
use ieee.std_logic_1164.all;

entity lab2_task1 is
 port (
  sw_i : in std_logic_vector(3 downto 0);
  led_o : out std_logic_vector(3 downto 0)
 );
end lab2_task1;

architecture Structural of lab2_task1 is
 component AND2_gate is
  port (X0, X1 : in std_logic; O : out std_logic);
 end component;
 component XOR2_gate is
  port (X0, X1 : in std_logic; O : out std_logic);
 end component;
 component NOT_gate is
  port (X0 : in std_logic; O : out std_logic);
 end component;
 component OR2_gate is
    port (X0, X1 : in std_logic; O : out std_logic);
  end component;
 signal not0, not1, not2, not3, or1, or2, and1, and2, and3, and4, and5, and6, and7, xor1, xor2, F3, F2, F1, F0 : std_logic;
begin 
 --X0'
 U1: NOT_gate port map (
  X0 => sw_i(0),
  O => not0
 );
 --X1'
 U2: NOT_gate port map (
  X0 => sw_i(1),
  O => not1
 );
 --X2'
 U3: NOT_gate port map (
  X0 => sw_i(2),
  O => not2
 );
 --X3'
 U4: NOT_gate port map (
  X0 => sw_i(3),
  O => not3
 );
 
 --F3: X1' + X0
 U5: OR2_gate port map (
  X0 => not1,
  X1 => sw_i(0),
  O => or1
 );
 --F3: X2*(X1'+X0)
 U6: AND2_gate port map (sw_i(2), or1, F3);
 
 --F2: X1*X2
 U7: AND2_gate port map (sw_i(1), sw_i(2), and1);
 --F2: X3 xor X1*X2
 U8: XOR2_gate port map (sw_i(3), and1, xor1);
 --F2: X0 xor X1*X2
 U9: XOR2_gate port map (sw_i(0), and1, xor2);
 --F2: (X3 xor X1*X2)*(X0 xor X1*X2)
 U10: AND2_gate port map (xor1, xor2, F2);
 
 --F1: X0'*X1'
 U11: AND2_gate port map (not0, not1, and2);
 --F1: X0'*X1'*X2
 U12: AND2_gate port map (and2, sw_i(2), and3);
 --F1: X0'*X1'*X2 + X1*X2'
 U13: OR2_gate port map (and3, and5, F1);
 
 --F0: X1*X2'
 U14: AND2_gate port map (sw_i(1), not2, and5);
 --F0: X3+X1*X2'
 U15: OR2_gate port map (sw_i(3), and5, or2);
 --F0: X0' * (X3+X1*X2')
 U16: AND2_gate port map (not0, or2, and4);
 --F0: X0*X1'
 U17: AND2_gate port map (sw_i(0), not1, and6);
 --F0: X0*X1'*X3'
 U18: AND2_gate port map (and6, not3, and7);
--F0: X0' * (X3+X1*X2') + X0*X1'*X3'
U19: OR2_gate port map (and4, and7, F0);
 
 led_o <= F3 & F2 & F1 & F0;
end architecture;
