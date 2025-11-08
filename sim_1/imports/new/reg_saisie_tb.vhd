library ieee;
use ieee.std_logic_1164.all;

entity reg_saisie_tb is
end reg_saisie_tb;

architecture Behavioral of reg_saisie_tb is
    signal clk : std_logic;
    signal rst : std_logic;
    signal en : std_logic_vector(3 downto 0);
    signal btn : std_logic_vector(2 downto 0);
    signal e1, e2, e3, e4 : std_logic_vector(3 downto 0);
begin

    utt: entity work.reg_saisie
    port map (
        clk => clk,
        rst => rst,
        en => en,
        btn => btn,
        e1 => e1, 
        e2 => e2, 
        e3 => e3, 
        e4 => e4
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
        
    rst_proc: process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait;
    end process;
    
    en_proc: process
    begin
        en <= x"0";
        wait for 5 ns;
        loop
            en <= x"0";
            wait for 10 ns;
            en <= x"1";
            wait for 10 ns;
            en <= x"2";
            wait for 10 ns;
            en <= x"3";
            wait for 10 ns;
        end loop;
    end process;
    
    btn_proc: process
    begin        
        loop
            btn <= "000";
            wait for 10 ns;
            btn <= "001";
            wait for 10 ns;
            btn <= "010";
            wait for 10 ns;
            btn <= "100";
            wait for 10 ns;
        end loop;
    end process;
    
end Behavioral;
