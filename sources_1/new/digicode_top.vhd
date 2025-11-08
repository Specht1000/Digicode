library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digicode_top is
    port (
        clk : in  std_logic;
        btn : in  std_logic_vector(3 downto 0);
        a_to_g : out std_logic_vector(6 downto 0);
        an : out std_logic_vector(3 downto 0);
        dp : out std_logic;
        led : out std_logic_vector(1 downto 0);
        sw : in std_logic_vector(7 downto 0)
    );
end digicode_top;

architecture Behavioral of digicode_top is
    signal clk_out_div, clk_out_pulse : std_logic;
    signal compteur_out : std_logic_vector(1 downto 0);
    signal out_multp : std_logic_vector(3 downto 0);
    signal en : std_logic_vector(3 downto 0);
    signal bn : std_logic_vector(1 downto 0) := (others => '0');
    signal btn012, start : std_logic;
    signal s1, s2, s3, s4 : std_logic_vector(3 downto 0);
    signal msg : std_logic_vector(1 downto 0);
begin

    clock_pulse: entity work.clock_pulse
    port map (
      clk => clk_out_div,
      rst => btn(3),
      entree => btn012,
      sortie => clk_out_pulse
    );

    clkdiv: entity work.clkdiv
    port map (
        mclk => clk,
        rst => btn(3),
        clk190 => clk_out_div
    );

    comp: entity work.compteur
    port map (
        clk => clk_out_div,
        rst => btn(3),
        sortie => compteur_out
    );

    hex7seg: entity work.hex7seg
    port map (
        clk => clk_out_div,
        rst => btn(3),
        bin => out_multp,
        a_to_g => a_to_g
    );
    
    gestion: entity work.gestion_an
    port map (
        rst => btn(3),
        entree => compteur_out,
        sortie => an
    );
    
    dp <= '1';

    
    reg: entity work.Reg_saisie
    port map (
        clk => clk_out_pulse,
        clk190 => clk_out_div,
        rst => btn(3),
        en => en,
        btn => bn,
        s1 => s1,
        s2 => s2,
        s3 => s3,
        s4 => s4,
        msg => msg
   );
   
     ctrl: entity work.digicode_control
     port map (
        clk => clk_out_pulse,
        rst => btn(3),
        bn => bn,
        sw => sw,
        led => msg,
        en => en
    );

    process(compteur_out, s1, s2, s3, s4)
    begin
        case compteur_out is
            when "00" => out_multp <= s1;
            when "01" => out_multp <= s2;
            when "10" => out_multp <= s3;
            when others => out_multp <= s4;
        end case;
    end process;

    bn(1) <= btn(2);
    bn(0) <= btn(1);
    btn012 <= btn(0) or btn(1) or btn(2);
    led <= msg;

end Behavioral;
