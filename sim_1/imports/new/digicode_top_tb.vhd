library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_digicode_top is
end entity;

architecture sim of tb_digicode_top is
  signal mclk   : std_logic := '0';
  signal btn    : std_logic_vector(3 downto 0) := (others => '0');
  signal sw     : std_logic_vector(7 downto 0) := (others => '0');
  signal ld     : std_logic_vector(1 downto 0);
  signal a_to_g : std_logic_vector(0 to 6);
  signal ans    : std_logic_vector(3 downto 0);

  constant Tclk : time := 10 ns;
begin
    uut: entity work.digicode_top
    port map (
      mclk   => mclk,
      btn    => btn,
      sw     => sw,
      ld     => ld,
      a_to_g => a_to_g,
      ans    => ans
    );

  -- clock 100 MHz
  clock : process
  begin
    while true loop
      mclk <= '0'; wait for Tclk/2;
      mclk <= '1'; wait for Tclk/2;
    end loop;
  end process;

  -- estimulos
  stim : process
  begin
    -- alvo 0,2,1,0 => x"24"
    sw <= x"24";

    -- reset longo (garante tudo zerado)
    btn(3) <= '1'; wait for 2 us; btn(3) <= '0';
    wait for 50 us;

    -- clique L (0)
    btn(0) <= '1'; wait for 2 ms; btn(0) <= '0'; wait for 1 ms;
    -- clique R (2)
    btn(2) <= '1'; wait for 2 ms; btn(2) <= '0'; wait for 1 ms;
    -- clique C (1)
    btn(1) <= '1'; wait for 2 ms; btn(1) <= '0'; wait for 1 ms;
    -- clique L (0)
    btn(0) <= '1'; wait for 2 ms; btn(0) <= '0';

    wait for 20 ms;  -- deixa a mensagem rolar

    -- sequência errada só para ver ERREUR
    btn(2) <= '1'; wait for 2 ms; btn(2) <= '0'; wait for 1 ms;
    btn(2) <= '1'; wait for 2 ms; btn(2) <= '0'; wait for 1 ms;
    btn(2) <= '1'; wait for 2 ms; btn(2) <= '0'; wait for 1 ms;
    btn(2) <= '1'; wait for 2 ms; btn(2) <= '0';

    wait for 20 ms;
    wait;
  end process;

end architecture;
