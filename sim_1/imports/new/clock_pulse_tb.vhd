library ieee;
use ieee.std_logic_1164.all;

entity clock_pulse_tb is
end clock_pulse_tb;

architecture Behavioral of clock_pulse_tb is
    constant N : integer := 3;
    
    signal clk : std_logic;
    signal rst : std_logic;
    signal entree : std_logic;
    signal sortie : std_logic;

begin
    
    clock_pulse_1 : entity work.clock_pulse
    generic map (N => N)
    port map (
        clk => clk, 
        rst => rst, 
        entree => entree, 
        sortie => sortie
    );
    
    entree_proc: process 
    begin
        entree <= '0';
        wait for 1000 ns;
        wait for 250 ns;
        entree <= '1';
        wait for 1000 ns;
        entree <= '0';
        wait for 1000 ns;
        entree <= '1';
        wait for 4*500 ns;
    end process;
    
    clk_proc: process 
    begin
        clk <= '0';
        wait for 500 ns;
        loop 
            clk <= not (clk);
            wait for 500 ns;
        end loop;
    end process;
        
    rst_clock: process
    begin
        rst <= '1';
        wait for 1000 ns;
        rst <= '0';
        wait;
    end process;

end Behavioral;
