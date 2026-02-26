library IEEE;
use ieee.std_logic_1164.all;

entity lab2_task6 is
    port (
        led_o: out std_logic;
        sw_i: in std_logic_vector(1 downto 0)
    );
end lab2_task6;

architecture rtl of lab2_task6  is
    signal Q: std_logic := '1';
    signal not_Q: std_logic := '0';
    attribute KEEP: string;
    attribute KEEP of Q: signal is "TRUE";
    attribute KEEP of not_Q: signal is "TRUE";
    attribute DONT_TOUCH: string;
    attribute DONT_TOUCH of Q: signal is "TRUE";
    attribute DONT_TOUCH of not_Q: signal is "TRUE";
    
    constant DELAY: time := 1 ns;
    
    signal data, op: std_logic;
begin
    data <= sw_i(0);
    op <= sw_i(1);
    not_Q <= not (((not op) and Q) or (op and data));
    Q <= not not_Q after DELAY;
    led_o <= Q;
end rtl;