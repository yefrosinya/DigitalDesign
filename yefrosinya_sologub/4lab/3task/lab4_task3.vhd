library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab4_task3 is
	generic (
		FLOOR_AMOUNT: positive := 4
	);
	port (
		CLK, RST, DOOR_OPEN_SENSOR, DOOR_CLOSED_SENSOR, TIMEOUT: in std_logic;
		CALL, FLOOR_SENSOR: in std_logic_vector(FLOOR_AMOUNT-1 downto 0);
		MOTOR_UP, MOTOR_DOWN, DOOR_OPEN_CMD, DOOR_CLOSE_CMD: out std_logic
	);
end lab4_task3;

architecture rtl of lab4_task3 is
	type t_states is (S_IDLE, S_MOVE, S_OPEN, S_WAIT, S_CLOSE);
	signal cur_state: t_states := S_IDLE;
	signal calls_reg: std_logic_vector(FLOOR_AMOUNT-1 downto 0) := (others => '0');
	signal cur_floor, target_floor: natural range 0 to FLOOR_AMOUNT-1 := 0;
	signal direction: std_logic := '1';

	function has_calls_above(calls: std_logic_vector; floor: natural) return boolean is
	begin
		for i in 0 to FLOOR_AMOUNT-1 loop
			if i > floor and calls(i) = '1' then
				return true;
			end if;
		end loop;
		return false;
	end function;

	function has_calls_below(calls: std_logic_vector; floor: natural) return boolean is
	begin
		for i in 0 to FLOOR_AMOUNT-1 loop
			if i < floor and calls(i) = '1' then
				return true;
			end if;
		end loop;
		return false;
	end function;

	function nearest_above(calls: std_logic_vector; floor: natural) return natural is
	begin
		for i in 0 to FLOOR_AMOUNT-1 loop
			if i > floor and calls(i) = '1' then
				return i;
			end if;
		end loop;
		return floor;
	end function;

	function nearest_below(calls: std_logic_vector; floor: natural) return natural is
		variable res: natural := floor;
	begin
		for i in 0 to FLOOR_AMOUNT-1 loop
			if i < floor and calls(i) = '1' then
				res := i;
			end if;
		end loop;
		return res;
	end function;

begin
	process(CLK, RST)
	begin
		if RST = '1' then
			calls_reg <= (others => '0');
		elsif rising_edge(CLK) then
			for i in 0 to FLOOR_AMOUNT-1 loop
				if CALL(i) = '1' then
					calls_reg(i) <= '1';
				end if;
			end loop;
			if cur_state = S_OPEN then
				calls_reg(cur_floor) <= '0';
			end if;
		end if;
	end process;

	process(CLK, RST)
	begin
		if RST = '1' then
			cur_floor <= 0;
		elsif rising_edge(CLK) then
			for i in 0 to FLOOR_AMOUNT-1 loop
				if FLOOR_SENSOR(i) = '1' then
					cur_floor <= i;
				end if;
			end loop;
		end if;
	end process;

	process(CLK, RST)
	begin
		if RST = '1' then
			cur_state <= S_IDLE;
			target_floor <= 0;
			direction <= '1';
		elsif rising_edge(CLK) then
			case cur_state is
				when S_IDLE =>
					if calls_reg /= (calls_reg'range => '0') then
						if calls_reg(cur_floor) = '1' then
							cur_state <= S_OPEN;
						elsif direction = '1' then
							if has_calls_above(calls_reg, cur_floor) then
								target_floor <= nearest_above(calls_reg, cur_floor);
								cur_state <= S_MOVE;
							elsif has_calls_below(calls_reg, cur_floor) then
								direction <= '0';
								target_floor <= nearest_below(calls_reg, cur_floor);
								cur_state <= S_MOVE;
							end if;
						else
							if has_calls_below(calls_reg, cur_floor) then
								target_floor <= nearest_below(calls_reg, cur_floor);
								cur_state <= S_MOVE;
							elsif has_calls_above(calls_reg, cur_floor) then
								direction <= '1';
								target_floor <= nearest_above(calls_reg, cur_floor);
								cur_state <= S_MOVE;
							end if;
						end if;
					end if;
				when S_MOVE =>
					if (cur_floor = target_floor) or (FLOOR_SENSOR(cur_floor) = '1' and calls_reg(cur_floor) = '1') then
						cur_state <= S_OPEN;
					end if;
				when S_OPEN =>
					if DOOR_OPEN_SENSOR = '1' then
						cur_state <= S_WAIT;
					end if;
				when S_WAIT =>
					if TIMEOUT = '1' then
						cur_state <= S_CLOSE;
					end if;
				when S_CLOSE =>
					if DOOR_CLOSED_SENSOR = '1' then
						cur_state <= S_IDLE;
					end if;
			end case;
		end if;
	end process;

	MOTOR_UP <= '1' when (cur_state = S_MOVE and target_floor > cur_floor) else '0';
	MOTOR_DOWN <= '1' when (cur_state = S_MOVE and target_floor < cur_floor) else '0';
	DOOR_OPEN_CMD <= '1' when cur_state = S_OPEN else '0';
	DOOR_CLOSE_CMD <= '1' when cur_state = S_CLOSE else '0';
end rtl;