library ieee;
use ieee.std_logic_1164.all;

entity lab4_task1 is
port (
 CLK, RST, EN: in std_logic;
 Q: out std_logic_vector(2 downto 0)
);
end lab4_task1;

architecture rtl of lab4_task1 is
 type t_states is (S_A, S_B_up, S_B_down, S_C_up, S_C_down, S_D_up, S_D_down, S_E_up, S_E_down, S_F);
 signal cur_state: t_states := S_A;
begin

 process(CLK)
 begin
  if rising_edge(CLK) then
   if RST = '1' then
    cur_state <= S_A;
   elsif EN = '1' then
    case cur_state is 
     when S_A => cur_state <= S_B_up;
     when S_B_up => cur_state <= S_C_up;
     when S_C_up => cur_state <= S_D_up;
     when S_D_up => cur_state <= S_E_up;
     when S_E_up => cur_state <= S_F;
     when S_F => cur_state <= S_E_down;
     when S_E_down => cur_state <= S_D_down;
     when S_D_down => cur_state <= S_C_down;
     when S_C_down => cur_state <= S_B_down;
     when S_B_down => cur_state <= S_A;
     when others => cur_state <= S_A;
    end case;
   end if;
  end if;
 end process;
 
 process(cur_state)
 begin
  case cur_state is
   when S_A => Q <= "001";
   when S_B_up | S_B_down => Q <= "010";
   when S_C_up | S_C_down => Q <= "011";
   when S_D_up | S_D_down => Q <= "100";
   when S_E_up | S_E_down => Q <= "101";
   when S_F => Q <= "110";
   when others => Q <= "001";
  end case;
 end process;
end rtl;