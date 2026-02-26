library IEEE;
use ieee.std_logic_1164.all;

entity lab2_task3 is
 port (
  sw_i : in std_logic_vector(3 downto 0);
  led_o : out std_logic_vector(3 downto 0)
 );
end lab2_task3;

architecture Structural of lab2_task3 is
 component Gate is 
  generic (GATE_TYPE : string := "AND2"; DELAY : time);
  port (
   X0: in std_logic;
    X1: in std_logic := '0';
   O: out std_logic
  );
 end component;
 component Interconnect is
  generic (
   WIDTH : integer := 1;
   DELAY : time := 1 ns
  );
  port (
   bus_i: in std_logic_vector(WIDTH-1 downto 0);
   bus_o: out std_logic_vector(WIDTH-1 downto 0)
  );
 end component;
 
 constant G_DELAY : time := 1 ns;
 constant W_DELAY : time := 1 ns;
 constant WIRE_WIDTH: integer := 4;
 
 signal sw_delayed, result_delayed: std_logic_vector(WIRE_WIDTH-1 downto 0);
 signal not0, not0_delayed, not1, not2, not3, or1, or2, and1, and2, and3, and4, and5, and6, and10, xor1, xor2, xor3, F3, F2, F1, F0 : std_logic;
begin 
 W1: Interconnect 
  generic map (WIDTH => WIRE_WIDTH, DELAY => W_DELAY) 
  port map (bus_i => sw_i, bus_o => sw_delayed);
 -- X0'
 U1: Gate 
  generic map ("NOT", G_DELAY) 
  port map (X0 => sw_delayed(0), O => not0);
 W2: Interconnect 
  generic map (WIDTH => 1, DELAY => W_DELAY) 
  port map (bus_i(0) => not0, bus_o(0) => not0_delayed);
 -- X1'
 U2: Gate generic map ("NOT", G_DELAY) port map (X0 => sw_delayed(1), O => not1);
 --X2'
 U3: Gate generic map ("NOT", G_DELAY) port map (X0 => sw_delayed(2), O => not2);
 --X3'
 U4: Gate generic map ("NOT", G_DELAY) port map (X0 => sw_delayed(3), O => not3);
 --F3: X1' + X0
 U5: Gate generic map ("OR2", G_DELAY) port map (X0 => not1, X1 => sw_delayed(0), O => or1);
 --F3: X2*(X1'+X0)
 U6: Gate generic map (DELAY => G_DELAY) port map (sw_delayed(2), or1, F3);
 
 
 --F2: X1*X2
 U7: Gate generic map (DELAY => G_DELAY) port map (sw_delayed(1), sw_delayed(2), and1);
 --F2: X3 xor X1*X2
 U8: Gate generic map ("XOR2", G_DELAY) port map (sw_delayed(3), and1, xor1);
 --F2: X0 xor X1*X2
 U9: Gate generic map ("XOR2", G_DELAY) port map (sw_delayed(0), and1, xor2);
 --F2: (X3 xor X1*X2)*(X0 xor X1*X2)
 U10: Gate generic map (DELAY => G_DELAY) port map (xor1, xor2, F2);
 
 --F1: X0'*X1'
 -- ZERO DELAYED
 U11: Gate generic map (DELAY => G_DELAY) port map (not0_delayed, not1, and2);
 --F1: X0'*X1'*X2
 U12: Gate generic map (DELAY => G_DELAY) port map (and2, sw_delayed(2), and3);
 --F1: X1*X2'
 U121: Gate generic map (DELAY => G_DELAY) port map (sw_delayed(1), not2, and10);
 --F1: X0'*X1'*X2 + X1*X2'
 U13: Gate generic map ("OR2", G_DELAY) port map (and3, and10, F1);
 
 --F0: X3 + X1*X2'
 U14: Gate generic map ("OR2", G_DELAY) port map (sw_delayed(3), and10, or2);
  --F0: X0' * (X3 + X1*X2')
 U141: Gate generic map ("AND2", G_DELAY) port map (not0_delayed, or2, and5);
 --F0: X1'*X3'
 U15: Gate generic map (DELAY => G_DELAY) port map (not1, not3, and4);
 --F0: X0 * X1'*X3'
 U16: Gate generic map (DELAY => G_DELAY) port map (sw_delayed(0), and4, and6);
 --F0: X0' * (X3 + X1*X2') + X0 * X1'*X3'
 U17: Gate generic map ("OR2", G_DELAY) port map (and5, and6, F0);
   

  W3: Interconnect 
  generic map (WIDTH => WIRE_WIDTH, DELAY => W_DELAY) 
  port map (
    bus_i(0) => F0, 
    bus_i(1) => F1, 
    bus_i(2) => F2, 
    bus_i(3) => F3,
    bus_o => result_delayed);
  
 led_o <= result_delayed;
end architecture;
