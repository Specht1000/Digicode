library ieee;
use ieee.std_logic_1164.all;

entity digicode_top is
    port (
        mclk      : in  std_logic;
        btn       : in  std_logic_vector(3 downto 0);
        sw        : in  std_logic_vector(7 downto 0);
        ld        : out std_logic_vector(1 downto 0);
        a_to_g    : out std_logic_vector(0 to 6);
        ans       : out std_logic_vector(3 downto 0)
    );
end digicode_top;

architecture Behavioral of digicode_top is

    constant L : integer := 25; -- 3 Hz
    constant N : integer := 3;  -- 4 dígitos no display
    constant M : integer := 19; -- 190 Hz

    signal clk3 : std_logic;
    signal clk190 : std_logic;
    signal pulse : std_logic;
    signal btn012 : std_logic;
    signal rst : std_logic;
    signal count : std_logic_vector(1 downto 0);
    signal a1, a2, a3, a4 : std_logic_vector(3 downto 0);
    signal e1, e2, e3, e4 : std_logic_vector(3 downto 0);
    signal hex : std_logic_vector(3 downto 0);
    signal en : std_logic_vector(3 downto 0);
    signal msg : std_logic_vector(63 downto 0);
    signal msg_len : std_logic_vector(3 downto 0);
    signal msg_rst : std_logic;
    signal msg_finished : std_logic;

begin

    clkdiv_1 : entity work.clkdiv
        generic map (N => L)
        port map (
            mclk => mclk,
            rst => rst,
            clk190 => clk3
        );

    clkdiv_2 : entity work.clkdiv
        generic map (N => M)
        port map (
            mclk  => mclk,
            rst => rst,
            clk190 => clk190
        );

    clock_pulse_1 : entity work.clock_pulse
        generic map (N => N)
        port map (
            clk => clk190,
            rst => rst,
            entree => btn012,
            sortie => pulse
        );

    digicode_control_1 : entity work.digicode_control
        port map (
            clk => pulse,
            rst => rst,
            sw => sw,
            bn => btn(2 downto 1),
            ld => ld,
            en => en,
            msg_finished => msg_finished,
            msg => msg,
            msg_len => msg_len,
            msg_rst => msg_rst
        );

    compteur_1 : entity work.compteur
        port map (
            clk => clk190,
            rst => rst,
            sortie => count
        );

    gestion_an_1 : entity work.gestion_an
        port map (
            clk => clk190,
            rst => rst,
            count => count,
            ans => ans
        );

    msg_reg_1 : entity work.msg_reg
        port map (
            clk => clk3,
            rst => msg_rst,
            msg => msg,
            len => msg_len,
            finished => msg_finished,
            a1 => a1,
            a2 => a2,
            a3 => a3,
            a4 => a4,
            e1 => e1,
            e2 => e2,
            e3 => e3,
            e4 => e4
        );

    mux_1 : entity work.mux
        port map (
            sel => count,
            e1 => e1,
            e2 => e2,
            e3 => e3,
            e4 => e4,
            sortie => hex
        );

    hex7seg_1 : entity work.hex7seg
        port map (
            hex => hex,
            a_to_g => a_to_g
        );

    reg_saisie_1 : entity work.reg_saisie
        port map (
            clk => pulse,
            rst => rst,
            en => en,
            btn => btn(2 downto 0),
            e1 => a1,
            e2 => a2,
            e3 => a3,
            e4 => a4
        );

    rst    <= btn(3);
    btn012 <= btn(0) or btn(1) or btn(2);

end Behavioral;
