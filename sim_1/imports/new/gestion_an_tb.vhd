library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gestion_an_tb is
end gestion_an_tb;

architecture Behavioral of gestion_an_tb is
    
    signal clk : std_logic;
    signal rst : std_logic;
    signal count : std_logic_vector(1 downto 0);
    signal ans : std_logic_vector(3 downto 0);
begin
    
    utt: entity work.gestion_an
    port map (clk => clk,rst => rst,count => count,ans => ans );
    
    clk_proc: process 
    begin
        clk <= '0';
        wait for 5 ns;
        loop 
            clk <= not (clk);
            wait for 5 ns;
        end loop;
    end process;
        
    rst_proc: process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait;
    end process;
    
    count_proc: process
    begin
        count <= "00";
        wait for 20 ns;
        loop
            count <= count + 1;
            wait for 10 ns;    
        end loop;
    end process;
    
end Behavioral;
