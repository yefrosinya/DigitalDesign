library ieee;
use ieee.std_logic_1164.all;

entity Task6 is
  port (
    sw : in std_logic_vector(3 downto 0);
    led : out std_logic_vector(3 downto 0)
  );
end Task6;

architecture rtl of Task6 is
    signal G3, G2, G1, G0 : std_logic;
    signal n_G3, n_G2, n_G1, n_G0 : std_logic;
    signal L0, L1, L2, L3 : std_logic;
begin
    G3 <= sw(3);
    G2 <= sw(2);
    G1 <= sw(1);
    G0 <= sw(0);

    n_G3 <= not G3;
    n_G2 <= not G2;
    n_G1 <= not G1;
    n_G0 <= not G0;

    L0 <= (n_G3 and n_G2 and G0) or
          (G3 and n_G2 and n_G0) or
          (G3 and G2 and n_G1 and n_G0);

    L1 <= (n_G3 and n_G2 and G1) or
          (G3 and n_G2 and n_G1 and n_G0) or
          (G3 and n_G2 and G1 and G0) or
          (G3 and G2 and n_G1 and n_G0);

    L2 <= (n_G3 and G2 and n_G1 and n_G0) or
          (G3 and n_G2 and (G1 or G0)) or
          (G3 and G2 and n_G1 and n_G0);

    L3 <= (G3 and n_G2) or
          (G3 and G2 and n_G1 and n_G0);

    led(0) <= L0;
    led(1) <= L1;
    led(2) <= L2;
    led(3) <= L3;
end rtl;