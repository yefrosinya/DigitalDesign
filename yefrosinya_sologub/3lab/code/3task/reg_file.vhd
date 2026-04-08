library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is
    generic (
        M: integer := 4; --ол-во регистров
        N: integer := 8 -- разрядность регистров
    );
    port (
       CLK, RST, W_EN: in std_logic;
       W_Addr, R_Addr: in std_logic_vector(1 downto 0);
       W_Data: in std_logic_vector(N-1 downto 0);
       R_Data: out std_logic_vector(N-1 downto 0)
    );
end reg_file;

architecture rtl of reg_file is
    signal reg_en: std_logic_vector(M-1 downto 0); -- кто будет писать
    type bus_type is array (0 to M-1) of std_logic_vector(N-1 downto 0);
    signal result: bus_type;
begin
    -- дешифратор
    enable_proc: process(W_Addr, W_EN)
    begin
        reg_en <= (others => '0');
        if W_EN = '1' then
            reg_en(to_integer(unsigned(W_Addr))) <= '1';
        end if;
    end process;
    
    gen_reg: for i in 0 to M-1 generate
        uut: entity work.reg_unit
            generic map (N => N) port map (
                CLK => CLK,
                RST => RST,
                EN => reg_en(i),
                Din => W_Data,
                Dout => result(i)         
            );
    end generate;
    
    -- мультиплексор
    R_Data <= result(to_integer(unsigned(R_Addr)));
        
    
end rtl;