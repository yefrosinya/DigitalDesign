library IEEE;
use ieee.std_logic_1164.all;

entity lab2_task4 is 
 port (
  sw_i: in std_logic_vector(5 downto 0);
  led_o: out std_logic_vector(2 downto 0)
 );
end lab2_task4;

architecture Structural of lab2_task4 is
 component Gate is 
  generic (GATE_TYPE: string := "AND2");
  port (
   X0: in std_logic;
   X1: in std_logic := '0';
   O: out std_logic
  );
 end component;
  
  signal and1, and2, and3, and4, and5, or1, or2, equals, less, greater: std_logic;
  signal inversed: std_logic_vector(5 downto 0);
  signal xnor_bits, gt_bits, lt_bits: std_logic_vector(2 downto 0);
  begin
 -- Equals 
 Eq: for i in 0 to 2 generate
  U1: Gate generic map ("XNOR2") port map (sw_i(i), sw_i(i+3), xnor_bits(i));
 end generate;
 U2: Gate port map (xnor_bits(0), xnor_bits(1), and1);
 U3: Gate port map (and1, xnor_bits(2), equals);
 
 -- Inversion
 INV: for i in 0 to 5 generate
  U4: Gate generic map ("NOT") port map (X0 => sw_i(i), O => inversed(i)); 
 end generate;
 
 GT: for i in 0 to 2 generate
  U5: Gate port map (sw_i(i), inversed(i+3), gt_bits(i));
 end generate;
 
 LT: for i in 0 to 2 generate
  U6: Gate port map (sw_i(i+3), inversed(i), lt_bits(i));
 end generate;
 
 -- Less continue
 U7: Gate port map (lt_bits(0), xnor_bits(1), and2);
 
 U8: Gate generic map ("OR2") port map (lt_bits(1), and2, or1); 
 U9: Gate port map (xnor_bits(2), or1, and3);
 U10: Gate generic map ("OR2") port map (lt_bits(2), and3, less); 
 
 -- Greater continue
 U11: Gate port map (gt_bits(0), xnor_bits(1), and4);
 U12: Gate generic map ("OR2") port map (gt_bits(1), and4, or2); 
 U13: Gate port map (xnor_bits(2), or2, and5);
 U14: Gate generic map ("OR2") port map (gt_bits(2), and5, greater);
  
 led_o <= less & equals & greater; 
end architecture;
