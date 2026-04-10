library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_2r1w is
    generic (
        ADDR_WIDTH: natural := 5;
        DATA_WIDTH: natural := 16
    );
    port (
        CLK, CLR, W_EN: std_logic;
        W_ADDR, R_ADDR_0, R_ADDR_1: in std_logic_vector(ADDR_WIDTH-1 downto 0);
        W_DATA: in std_logic_vector(DATA_WIDTH-1 downto 0);
        R_DATA_0, R_DATA_1: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end reg_file_2r1w;

architecture rtl of reg_file_2r1w is
    subtype t_reg_word is std_logic_vector(DATA_WIDTH-1 downto 0);
    type t_reg_file is array (0 to 2**ADDR_WIDTH-1) of t_reg_word;
    signal REG_FILE: t_reg_file;
begin
    proc: process(CLK, CLR, R_ADDR_0, R_ADDR_1)
    begin
        if CLR = '1' then
            for i in 0 to 2**ADDR_WIDTH-1 loop
                REG_FILE(i) <= (others => '0');
            end loop;
        elsif rising_edge(CLK) then
            if W_EN = '1' then
                REG_FILE(to_integer(unsigned(W_ADDR))) <= W_DATA;
            end if;
        end if;
    end process;
    
    R_DATA_0 <= W_DATA when (W_EN ='1' and R_ADDR_0 = W_ADDR) else REG_FILE(to_integer(unsigned(R_ADDR_0)));
    R_DATA_1 <= W_DATA when (W_EN ='1' and R_ADDR_1 = W_ADDR) else REG_FILE(to_integer(unsigned(R_ADDR_1)));
end;