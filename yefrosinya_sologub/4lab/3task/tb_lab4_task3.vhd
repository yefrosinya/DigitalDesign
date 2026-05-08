library ieee; 
use ieee.std_logic_1164.all; 
 
entity tb_lab4_task3 is 
end tb_lab4_task3; 
 
architecture rtl of tb_lab4_task3 is 
 signal CLK : std_logic := '0'; 
 signal RST : std_logic := '0'; 
 signal DOOR_OPEN_SENSOR : std_logic := '0'; 
 signal DOOR_CLOSED_SENSOR : std_logic := '0'; 
 signal TIMEOUT : std_logic := '0'; 
 signal CALL : std_logic_vector(3 downto 0) := (others => '0'); 
 signal FLOOR_SENSOR : std_logic_vector(3 downto 0) := (others => '0'); 
 signal MOTOR_UP : std_logic; 
 signal MOTOR_DOWN : std_logic; 
 signal DOOR_OPEN_CMD : std_logic; 
 signal DOOR_CLOSE_CMD : std_logic; 
begin 
 uut : entity work.lab4_task3 
  generic map (FLOOR_AMOUNT => 4) 
  port map ( 
   CLK => CLK, 
   RST => RST, 
   DOOR_OPEN_SENSOR => DOOR_OPEN_SENSOR, 
   DOOR_CLOSED_SENSOR => DOOR_CLOSED_SENSOR, 
   TIMEOUT => TIMEOUT, 
   CALL => CALL, 
   FLOOR_SENSOR => FLOOR_SENSOR, 
   MOTOR_UP => MOTOR_UP, 
   MOTOR_DOWN => MOTOR_DOWN, 
   DOOR_OPEN_CMD => DOOR_OPEN_CMD, 
   DOOR_CLOSE_CMD => DOOR_CLOSE_CMD 
  ); 
 
 CLK <= not CLK after 5 ns; 
 
 process 
 begin 
  RST <= '1'; 
  FLOOR_SENSOR <= "0001"; 
  wait for 20 ns; 
  RST <= '0'; 
  wait for 10 ns; 
 
  CALL <= "0100"; 
  wait for 10 ns; 
  CALL <= "0000"; 
  wait for 20 ns; 
  assert MOTOR_UP = '1' 
   report "S1: MOTOR_UP expected 1" severity error; 
  assert MOTOR_DOWN = '0' 
   report "S1: MOTOR_DOWN expected 0" severity error; 
 
  FLOOR_SENSOR <= "0100"; 
  wait for 20 ns; 
  assert DOOR_OPEN_CMD = '1' 
   report "S1: DOOR_OPEN_CMD expected 1" severity error; 
  assert MOTOR_UP = '0' 
   report "S1: MOTOR_UP expected 0 at target floor" severity error; 
 
  DOOR_OPEN_SENSOR <= '1'; 
  wait for 10 ns; 
  DOOR_OPEN_SENSOR <= '0'; 
  wait for 20 ns; 
  assert DOOR_OPEN_CMD = '0' 
   report "S1: DOOR_OPEN_CMD expected 0 in S_WAIT" severity error; 
 
  TIMEOUT <= '1'; 
  wait for 10 ns; 
  TIMEOUT <= '0'; 
  wait for 10 ns; 
  assert DOOR_CLOSE_CMD = '1' 
   report "S1: DOOR_CLOSE_CMD expected 1" severity error; 
 
  DOOR_CLOSED_SENSOR <= '1'; 
  wait for 10 ns; 
  DOOR_CLOSED_SENSOR <= '0'; 
  wait for 20 ns; 
  assert MOTOR_UP = '0' 
   report "S1: MOTOR_UP expected 0 in S_IDLE" severity error; 
  assert MOTOR_DOWN = '0' 
   report "S1: MOTOR_DOWN expected 0 in S_IDLE" severity error; 
  assert DOOR_OPEN_CMD = '0' 
   report "S1: DOOR_OPEN_CMD expected 0 in S_IDLE" severity error; 
  assert DOOR_CLOSE_CMD = '0' 
   report "S1: DOOR_CLOSE_CMD expected 0 in S_IDLE" severity error; 
 
  CALL <= "1000"; 
  wait for 10 ns; 
  CALL <= "0000"; 
  wait for 20 ns; 
  assert MOTOR_UP = '1' 
   report "S2a: MOTOR_UP expected 1" severity error; 
 
  FLOOR_SENSOR <= "1000"; 
  wait for 20 ns; 
  assert DOOR_OPEN_CMD = '1' 
   report "S2a: DOOR_OPEN_CMD expected 1" severity error; 
  assert MOTOR_UP = '0' 
   report "S2a: MOTOR_UP expected 0 at target floor" severity error; 
 
  DOOR_OPEN_SENSOR <= '1'; 
  wait for 10 ns; 
  DOOR_OPEN_SENSOR <= '0'; 
  wait for 20 ns; 
  TIMEOUT <= '1'; 
  wait for 10 ns; 
  TIMEOUT <= '0'; 
  wait for 10 ns; 
  DOOR_CLOSED_SENSOR <= '1'; 
  wait for 10 ns; 
  DOOR_CLOSED_SENSOR <= '0'; 
  wait for 20 ns; 
 
  CALL <= "0010"; 
  wait for 10 ns; 
  CALL <= "0000"; 
  wait for 20 ns; 
  assert MOTOR_DOWN = '1' 
   report "S2b: MOTOR_DOWN expected 1" severity error; 
  assert MOTOR_UP = '0' 
   report "S2b: MOTOR_UP expected 0" severity error; 
 
  FLOOR_SENSOR <= "0010"; 
  wait for 20 ns; 
  assert DOOR_OPEN_CMD = '1' 
   report "S2b: DOOR_OPEN_CMD expected 1" severity error; 
 
  DOOR_OPEN_SENSOR <= '1'; 
  wait for 10 ns; 
  DOOR_OPEN_SENSOR <= '0'; 
  wait for 20 ns; 
  TIMEOUT <= '1'; 
  wait for 10 ns; 
  TIMEOUT <= '0'; 
  wait for 10 ns; 
  assert DOOR_CLOSE_CMD = '1' 
   report "S2b: DOOR_CLOSE_CMD expected 1" severity error; 
  DOOR_CLOSED_SENSOR <= '1'; 
  wait for 10 ns; 
  DOOR_CLOSED_SENSOR <= '0'; 
  wait for 20 ns; 
 
  CALL <= "1000"; 
  wait for 10 ns; 
  CALL <= "0000"; 
  wait for 30 ns; 
  CALL <= "0100"; 
  wait for 10 ns; 
  CALL <= "0000"; 
  wait for 10 ns; 
  FLOOR_SENSOR <= "0100"; 
  wait for 20 ns;
  assert DOOR_OPEN_CMD = '1' 
     report "S3: DOOR_OPEN_CMD expected 1 at intermediate floor" severity error; 
assert MOTOR_UP = '0' 
 report "S3: MOTOR_UP expected 0 at intermediate floor" severity error; 

DOOR_OPEN_SENSOR <= '1'; 
wait for 10 ns; 
DOOR_OPEN_SENSOR <= '0'; 
wait for 20 ns; 
TIMEOUT <= '1'; 
wait for 10 ns; 
TIMEOUT <= '0'; 
wait for 10 ns; 
DOOR_CLOSED_SENSOR <= '1'; 
wait for 10 ns; 
DOOR_CLOSED_SENSOR <= '0'; 
wait for 20 ns; 
assert MOTOR_UP = '1' 
 report "S3: MOTOR_UP expected 1 resuming to floor 4" severity error; 

FLOOR_SENSOR <= "1000"; 
wait for 20 ns; 
assert DOOR_OPEN_CMD = '1' 
 report "S3: DOOR_OPEN_CMD expected 1 at floor 4" severity error; 

DOOR_OPEN_SENSOR <= '1'; 
wait for 10 ns; 
DOOR_OPEN_SENSOR <= '0'; 
wait for 20 ns; 
TIMEOUT <= '1'; 
wait for 10 ns; 
TIMEOUT <= '0'; 
wait for 10 ns; 
DOOR_CLOSED_SENSOR <= '1'; 
wait for 10 ns; 
DOOR_CLOSED_SENSOR <= '0'; 

wait; 
end process; 
end rtl;