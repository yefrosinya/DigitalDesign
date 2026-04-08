library IEEE;
use ieee.std_logic_1164.all;

entity lab3_task3_tb is
end lab3_task3_tb;

architecture rtl of lab3_task3_tb is
    constant N_test : natural := 8; 
    signal CLK_test, EN_test, RST_test : std_logic;
    signal Din_test, Dout_test: std_logic_vector(N_test-1 downto 0);
    type test_record is record 
        EN, RST: std_logic;
        Din, Dout: std_logic_vector(N_test-1 downto 0);
    end record;
    type data_array is array(0 to 3) of test_record;
    constant TEST_DATA: data_array := (
        -- EN  RST   Din  Dout
        ( '1', '1', x"AA", x"00"),
        ( '1', '0', x"AC", x"AC"), 
        ( '0', '0', x"FF", x"AC"),
        ( '1', '1', x"AA", x"00") 
    );

    constant DELAY: time := 20 ns;

begin
    uut: entity work.reg_unit 
        generic map (N => N_test) 
        port map (
            CLK => CLK_test,
            EN => EN_test,
            RST => RST_test,
            Din => Din_test,
            Dout => Dout_test
        ); 

    clk_proc: process
    begin
        CLK_test <= '0'; wait for 10 ns;
        CLK_test <= '1'; wait for 10 ns;
    end process;
    
    stim_proc: process
    begin
        wait for 10 ns; 
        for i in TEST_DATA'range loop
           EN_test <= TEST_DATA(i).EN;
           RST_test <= TEST_DATA(i).RST;
           Din_test <= TEST_DATA(i).Din;
           wait for DELAY; 
           assert (Dout_test = TEST_DATA(i).Dout) 
               report "Step: " & integer'image(i) & " failed"
           severity error;
        end loop; 

        report "Success"; 
        wait;
    end process;
end rtl;