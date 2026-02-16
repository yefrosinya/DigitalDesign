library ieee;
use ieee.std_logic_1164.all;

entity Task5 is
port (
    sw : in std_logic_vector(15 downto 0);
    led : out std_logic_vector(15 downto 0)
);
end Task5;

architecture rtl of Task5 is
begin
    process(sw)
        variable b_not : std_logic_vector(5 downto 0);
        variable sum : std_logic_vector(5 downto 0);
        variable carry : std_logic_vector(6 downto 0);
    begin
        case sw(3 downto 0) is
            when "0001" => 
                led(5 downto 0) <= not (sw(15 downto 10) or sw(9 downto 4));
                
            when "0010" => 
                led(5 downto 0) <= "000" & sw(15 downto 13);
                
            when "0100" => 
                led(5 downto 0) <= sw(15 downto 10) and sw(9 downto 4);
                
            when "1000" => 
                b_not := not sw(9 downto 4);
                carry(0) := '1';
                
                sum(0) := sw(10) xor b_not(0) xor carry(0);
                carry(1) := (sw(10) and b_not(0)) or (sw(10) and carry(0)) or (b_not(0) and carry(0));
                
                sum(1) := sw(11) xor b_not(1) xor carry(1);
                carry(2) := (sw(11) and b_not(1)) or (sw(11) and carry(1)) or (b_not(1) and carry(1));
                
                sum(2) := sw(12) xor b_not(2) xor carry(2);
                carry(3) := (sw(12) and b_not(2)) or (sw(12) and carry(2)) or (b_not(2) and carry(2));
                
                sum(3) := sw(13) xor b_not(3) xor carry(3);
                carry(4) := (sw(13) and b_not(3)) or (sw(13) and carry(3)) or (b_not(3) and carry(3));
                
                sum(4) := sw(14) xor b_not(4) xor carry(4);
                carry(5) := (sw(14) and b_not(4)) or (sw(14) and carry(4)) or (b_not(4) and carry(4));
                
                sum(5) := sw(15) xor b_not(5) xor carry(5);
                
                led(5 downto 0) <= sum;
                
            when others => 
                led(5 downto 0) <= (others => '0');
        end case;
        
        led(15 downto 6) <= (others => '0');
        
    end process;
end rtl;