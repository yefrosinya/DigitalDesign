library IEEE;
use ieee.std_logic_1164.all;

entity Task7 is
port (
    sw : in std_logic_vector(3 downto 0);
    led : out std_logic_vector(3 downto 0)
);
end Task7;

architecture Structural of Task7 is
    component MUX2 is
        port (
            A : in std_logic;
            B : in std_logic;
            S : in std_logic;
            Y : out std_logic
        );
    end component;

    component INV is
        port (
            A : in std_logic;
            Y : out std_logic
        );
    end component;

    signal n_sw0, n_sw1, n_sw2, n_sw3 : std_logic;
    signal L3_A, L3_B, L3_C : std_logic;
    signal L2_A, L2_B, L2_C, L2_D : std_logic;
    signal L1_A, L1_B, L1_C, L1_D, L1_E, L1_F, L1_G, L1_H, L1_I, L1_J : std_logic;
    signal L0_A, L0_B, L0_C, L0_D, L0_E, L0_F : std_logic;
    signal L3, L2, L1, L0 : std_logic;

begin
    INV0: INV port map (A => sw(0), Y => n_sw0);
    INV1: INV port map (A => sw(1), Y => n_sw1);
    INV2: INV port map (A => sw(2), Y => n_sw2);
    INV3: INV port map (A => sw(3), Y => n_sw3);

    MUX_AND_n_sw1_n_sw0: MUX2 port map (A => '0', B => n_sw0, S => n_sw1, Y => L3_A);
    MUX_AND_sw2_L3_A: MUX2 port map (A => '0', B => L3_A, S => sw(2), Y => L3_B);
    MUX_OR_n_sw2_L3_B: MUX2 port map (A => '1', B => L3_B, S => n_sw2, Y => L3_C);
    MUX_AND_sw3_L3_C: MUX2 port map (A => '0', B => L3_C, S => sw(3), Y => L3);

    MUX_AND_n_sw3_L3_B: MUX2 port map (A => '0', B => L3_B, S => n_sw3, Y => L2_A);
    MUX_AND_sw3_n_sw2: MUX2 port map (A => '0', B => n_sw2, S => sw(3), Y => L2_B);
    MUX_AND_sw3_L3_B: MUX2 port map (A => '0', B => L3_B, S => sw(3), Y => L2_C);
    MUX_OR_L2_A_L2_B: MUX2 port map (A => L2_A, B => '1', S => L2_B, Y => L2_D);
    MUX_OR_L2_D_L2_C: MUX2 port map (A => L2_D, B => '1', S => L2_C, Y => L2);

    MUX_AND_n_sw2_sw1: MUX2 port map (A => '0', B => sw(1), S => n_sw2, Y => L1_A);
    MUX_AND_n_sw3_L1_A: MUX2 port map (A => '0', B => L1_A, S => n_sw3, Y => L1_B);
    MUX_AND_n_sw2_L3_A: MUX2 port map (A => '0', B => L3_A, S => n_sw2, Y => L1_C);
    MUX_AND_sw3_L1_C: MUX2 port map (A => '0', B => L1_C, S => sw(3), Y => L1_D);
    MUX_AND_sw1_sw0: MUX2 port map (A => '0', B => sw(0), S => sw(1), Y => L1_E);
    MUX_AND_n_sw2_L1_E: MUX2 port map (A => '0', B => L1_E, S => n_sw2, Y => L1_F);
    MUX_AND_sw3_L1_F: MUX2 port map (A => '0', B => L1_F, S => sw(3), Y => L1_G);
    MUX_AND_sw3_L3_B_L1: MUX2 port map (A => '0', B => L3_B, S => sw(3), Y => L1_H);
    MUX_OR_L1_B_L1_D: MUX2 port map (A => L1_B, B => '1', S => L1_D, Y => L1_I);
    MUX_OR_L1_I_L1_G: MUX2 port map (A => L1_I, B => '1', S => L1_G, Y => L1_J);
    MUX_OR_L1_J_L1_H: MUX2 port map (A => L1_J, B => '1', S => L1_H, Y => L1);

    MUX_AND_n_sw2_sw0: MUX2 port map (A => '0', B => sw(0), S => n_sw2, Y => L0_A);
    MUX_AND_n_sw3_L0_A: MUX2 port map (A => '0', B => L0_A, S => n_sw3, Y => L0_B);
    MUX_AND_n_sw2_n_sw0: MUX2 port map (A => '0', B => n_sw0, S => n_sw2, Y => L0_C);
    MUX_AND_sw3_L0_C: MUX2 port map (A => '0', B => L0_C, S => sw(3), Y => L0_D);
    MUX_AND_sw3_L3_B_L0: MUX2 port map (A => '0', B => L3_B, S => sw(3), Y => L0_E);
    MUX_OR_L0_B_L0_D: MUX2 port map (A => L0_B, B => '1', S => L0_D, Y => L0_F);
    MUX_OR_L0_F_L0_E: MUX2 port map (A => L0_F, B => '1', S => L0_E, Y => L0);

    led <= L3 & L2 & L1 & L0;

end Structural;

library IEEE;
use ieee.std_logic_1164.all;

entity MUX2 is
    port (
        A : in std_logic;
        B : in std_logic;
        S : in std_logic;
        Y : out std_logic
    );
end MUX2;

architecture Behavioral of MUX2 is
begin
    Y <= A when S = '0' else B;
end Behavioral;

library IEEE;
use ieee.std_logic_1164.all;

entity INV is
    port (
        A : in std_logic;
        Y : out std_logic
    );
end INV;

architecture Behavioral of INV is
begin
    Y <= not A;
end Behavioral;