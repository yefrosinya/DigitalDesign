library ieee;
use ieee.std_logic_1164.all;

-- Task 5
-- 1st operation: xor
-- 2nd operation: <<< 2 (rotate left for 2)
-- 3rd operaion: nand
-- 4th operation: - (substraction)

entity alu_unit is
    port (
        sw_i    : in    std_logic_vector(15 downto 0);
        led_o   : out   std_logic_vector(15 downto 0)
   );
end alu_unit;

architecture rtl of alu_unit is
begin
    process (sw_i)
        variable remainder  :   std_logic_vector(5 downto 0);
        variable borrow     :   std_logic_vector(6 downto 0);
    begin
        led_o <= (others => '0');
        
        if sw_i(0) = '1' then
            led_o(5 downto 0) <= (sw_i(15 downto 10) xor sw_i(9 downto 4));
        elsif sw_i(1) = '1' then
            led_o(5 downto 0) <= sw_i(13 downto 10) & sw_i(15 downto 14);
        elsif sw_i(2) = '1' then
            led_o(5 downto 0) <= (sw_i(15 downto 10) nand sw_i(9 downto 4)); 
        elsif sw_i(3) = '1' then
            borrow(0) := '0';
            
            for i in 0 to 5 loop
                remainder(i) := sw_i(10 + i) xor sw_i(4 + i) xor borrow(i);
                
                borrow(i + 1) := ((not sw_i(10 + i)) and sw_i(4 + i)) or 
                                 ((not sw_i(10 + i)) and borrow(i)) or 
                                 (sw_i(4 + i) and borrow(i));
            end loop;
            
            led_o(5 downto 0) <= remainder;
        end if;
    end process;
end rtl;