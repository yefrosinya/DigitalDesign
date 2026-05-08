library ieee; 
use ieee.std_logic_1164.all; 
 
entity tb_lab4_task4 is 
end tb_lab4_task4; 
 
architecture rtl of tb_lab4_task4 is 
 signal CLK : std_logic := '0'; 
 signal RST : std_logic := '0'; 
 signal BTN : std_logic_vector(2 downto 0) := (others => '0'); 
 signal ADMIN_UNLOCK : std_logic := '0'; 
 signal LED_GREEN : std_logic; 
 signal LED_RED : std_logic; 
 signal LED_BLUE : std_logic; 
begin 
 uut : entity work.lab4_task4 
  generic map ( 
   BLINK_DIV => 4, 
   GREEN_TICKS => 19 
  ) 
  port map ( 
   CLK => CLK, 
   RST => RST, 
   BTN => BTN, 
   ADMIN_UNLOCK => ADMIN_UNLOCK, 
   LED_GREEN => LED_GREEN, 
   LED_RED => LED_RED, 
   LED_BLUE => LED_BLUE 
  ); 
 
 CLK <= not CLK after 5 ns; 
 
 process 
 begin 
  RST <= '1'; 
  wait for 20 ns; 
  RST <= '0'; 
  wait for 10 ns; 
 
  BTN <= "001"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  BTN <= "100"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  BTN <= "010"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  BTN <= "001"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  assert LED_GREEN = '1' 
   report "S1: LED_GREEN expected 1 after correct sequence" severity error; 
  assert LED_RED = '0' 
   report "S1: LED_RED expected 0" severity error; 
  assert LED_BLUE = '0' 
   report "S1: LED_BLUE expected 0 in S_ACCESS" severity error; 
 
  wait for 250 ns; 
 
  assert LED_GREEN = '0' 
   report "S1: LED_GREEN expected 0 after green timeout" severity error; 
 
  BTN <= "100"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  BTN <= "010"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  BTN <= "100"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  assert LED_RED = '1' 
   report "S2: LED_RED expected 1 after 3 errors" severity error; 
  assert LED_GREEN = '0' 
   report "S2: LED_GREEN expected 0 in deadlock" severity error; 
  assert LED_BLUE = '0' 
   report "S2: LED_BLUE expected 0 in deadlock" severity error; 
 
  BTN <= "001"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  assert LED_RED = '1' 
   report "S2: LED_RED expected 1, BTN alone does not unlock" severity error; 
 
  ADMIN_UNLOCK <= '1'; 
  BTN <= "001"; 
  wait for 20 ns; 
  ADMIN_UNLOCK <= '0'; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  assert LED_RED = '0' 
   report "S3: LED_RED expected 0 after admin unlock" severity error; 
  assert LED_GREEN = '0' 
   report "S3: LED_GREEN expected 0 after admin unlock" severity error; 
 
  BTN <= "001"; 
  wait for 20 ns; 
  BTN <= "000"; 
  wait for 10 ns; 
 
  RST <= '1'; 
  wait for 20 ns; 
  RST <= '0'; 
  wait for 10 ns; 
 
  assert LED_GREEN = '0' 
   report "S4: LED_GREEN expected 0 after RST" severity error; 
  assert LED_RED = '0' 
   report "S4: LED_RED expected 0 after RST" severity error; 
 
  wait; 
 end process; 
end rtl;