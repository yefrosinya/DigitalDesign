library IEEE;
use ieee.std_logic_1164.all;

entity lab3_task1_tb is
end lab3_task1_tb;

architecture rtl of lab3_task1_tb is
    signal nS_test, nR_test, Q_test, nQ_test : std_logic;
    type test is record 
        nS, nR, Q, nQ : std_logic;
     end record;
     type data_array is array(0 to 3) of test;
     constant TEST_DATA: data_array := (
        (nS => '0', nR => '1', Q => '1', nQ => '0'),
        (nS => '1', nR => '0', Q => '0', nQ => '1'),
        (nS => '1', nR => '1', Q => '0', nQ => '1'),
        (nS => '0', nR => '0', Q => '1', nQ => '1')
        );
        constant DELAY: time := 20 ns;
begin
    uut: entity work.lab3_task1 port map (nS => nS_test, nR => nR_test, Q => Q_test, nQ => nQ_test); 
    stim_proc: process
    begin
        wait for 10 ns;
        for i in TEST_DATA'range loop
           nS_test <= TEST_DATA(i).nS;
           nR_test <= TEST_DATA(i).nR;
           wait for DELAY;
           assert (Q_test = TEST_DATA(i).Q and nQ_test = TEST_DATA(i).nQ) 
               report "Step: " & integer'image(i) & ", Output: Q = " & std_logic'image(Q_test) & ", nQ = " & std_logic'image(nQ_test)
           severity error;
        end loop; 
        nS_test <= '1'; nR_test <= '1';
        wait for DELAY;
        report "Success"; 
        wait;
    end process;
end rtl;