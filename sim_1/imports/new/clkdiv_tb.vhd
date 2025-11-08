library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkdiv_tb is
end clkdiv_tb;

architecture Behavioral of clkdiv_tb is
    constant N : integer := 19;
    
    signal mclk : std_logic;
    signal rst : std_logic;
    signal clk190 : std_logic;

begin
    
    utt: entity work.clkdiv
    generic map (N => N)
    port map (mclk => mclk,rst => rst,clk190 => clk190);

    clk_proc: process 
    begin
        mclk <= '0';
        wait for 5 ns;
        loop 
            mclk <= not (mclk);
            wait for 5 ns;
        end loop;
    end process;
        
    rst_clock: process
    begin
        rst <= '1';
        wait for 2*5 ns;
        rst <= '0';
        wait;
    end process;
    
end Behavioral;
