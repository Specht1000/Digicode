library ieee;
use ieee.std_logic_1164.all;

entity compteur_tb is
end compteur_tb;

architecture Behavioral of compteur_tb is
    
    signal clk : std_logic;
    signal rst : std_logic;
    signal sortie: std_logic_vector(1 downto 0);

begin

    utt: entity work.compteur
    port map (
        clk => clk,
        rst => rst,
        sortie => sortie
    );
    
    clk_proc: process 
    begin
        clk <= '0';
        wait for 5 ns;
        loop 
            clk <= not (clk);
            wait for 5 ns;
        end loop;
    end process;
        
    rst_clock: process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait;
    end process;
    
end Behavioral;
