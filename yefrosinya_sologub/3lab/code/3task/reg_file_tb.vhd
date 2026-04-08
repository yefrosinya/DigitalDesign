library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_tb is
end reg_file_tb;

architecture rtl of reg_file_tb is
    constant M_test: integer := 4;
    constant N_test: integer := 8;
    constant T: time := 10 ns;
    signal CLK_test, RST_test: std_logic;
    signal w_addr_test, r_addr_test: std_logic_vector(1 downto 0);
    signal w_en_test: std_logic;
    signal w_data_test, r_data_test: std_logic_vector(N_test-1 downto 0);
    type test_record is record
        RST, W_EN: std_logic;
        W_Addr, R_Addr: std_logic_vector(1 downto 0);
        W_Data: std_logic_vector(N_test-1 downto 0);
        R_Data_Exp: std_logic_vector(N_test-1 downto 0);
    end record;

    type data_array is array(0 to 4) of test_record;

    constant TEST_DATA: data_array := (
        -- RST W_EN W_Addr R_Addr W_Data R_Data_Exp
        ( '1', '0', "00", "00", x"00", x"00" ), -- сброс 
        ( '0', '1', "01", "01", x"AC", x"AC" ), -- Запись и чтение из 1 регистра
        ( '0', '0', "01", "01", x"FF", x"AC" ), -- хранение
        ( '0', '1', "10", "01", x"55", x"AC" ),
        ( '0', '0', "00", "10", x"00", x"55" )  
    );
    constant DELAY: time := 20 ns;

begin
    uut: entity work.reg_file
        generic map (M => M_test, N => N_test)
        port map (
            CLK => CLK_test,
            RST => RST_test,
            W_Addr => w_addr_test,
            W_EN => w_en_test,
            W_Data => w_data_test,
            R_Addr => r_addr_test,
            R_Data => r_data_test
        );

    clk_proc: process
    begin
        CLK_test <= '0'; wait for T;
        CLK_test <= '1'; wait for T;
    end process;

    stim_proc: process
    begin
        wait for 10 ns; 
        for i in TEST_DATA'range loop
            RST_test <= TEST_DATA(i).RST;
            w_en_test <= TEST_DATA(i).W_EN;
            w_addr_test <= TEST_DATA(i).W_Addr;
            r_addr_test <= TEST_DATA(i).R_Addr;
            w_data_test <= TEST_DATA(i).W_Data;
            wait until rising_edge(CLK_test);
            wait for 5 ns; 
            assert (r_data_test = TEST_DATA(i).R_Data_Exp) 
                report "Step: " & integer'image(i) & " failed."
            severity error;
        end loop; 

        report "Success"; 
        wait;
    end process;
end rtl;