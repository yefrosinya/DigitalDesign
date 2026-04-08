library IEEE;
use ieee.std_logic_1164.all;

entity lab3_task2_tb is
end lab3_task2_tb;

architecture rtl of lab3_task2_tb is
    signal D_test, CLR_test, CLK_test, Q_test : std_logic;
    type test is record 
        D, CLR, Q : std_logic;
     end record;
     type data_array is array(0 to 4) of test;
     constant TEST_DATA: data_array := (
        (D => '1', CLR => '1', Q => '1'),
        (D => '0', CLR => '1', Q => '0'),
        (D => '1', CLR => '0', Q => '0'),
        (D => '1', CLR => '1', Q => '1'),
        (D => '0', CLR => '0', Q => '0')
        );
        constant DELAY: time := 20 ns;
begin
    uut: entity work.lab3_task2 port map (D => D_test, CLK => CLK_test, CLR_N => CLR_test, Q => Q_test); 
    clk_proc: process
    begin
    CLK_test <= '0';
    wait for 10 ns;
    CLK_test <= '1';
    wait for 10 ns;
    end process;
    
    stim_proc: process
    begin
        wait for 10 ns;
        for i in TEST_DATA'range loop
           D_test <= TEST_DATA(i).D;
           CLR_test <= TEST_DATA(i).CLR;
           wait for DELAY;
           assert (Q_test = TEST_DATA(i).Q) 
               report "Step: " & integer'image(i) & ", Output: Q = " & std_logic'image(Q_test)
           severity error;
        end loop; 
        report "Success"; 
        wait;
    end process;
end rtl;