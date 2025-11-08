library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digicode_control_tb is
end digicode_control_tb;

architecture Behavioral of digicode_control_tb is
    constant passwd : std_logic_vector(7 downto 0) := "10011001";
    
    signal clk : std_logic;
    signal rst : std_logic;
    signal sw : std_logic_vector(7 downto 0);
    signal bn : std_logic_vector(1 downto 0);
    signal ld : std_logic_vector(1 downto 0);
    signal en : std_logic_vector(3 downto 0);
    signal msg_finished : std_logic;
    signal msg : std_logic_vector(63 downto 0);
    signal msg_len : std_logic_vector(3 downto 0); 
    signal msg_rst : std_logic;
begin

    utt: entity work.digicode_control
    port map (
        clk => clk,
        rst => rst,
        sw => sw,
        bn => bn,
        ld => ld,
        en => en,
        msg_finished => msg_finished,
        msg => msg,
        msg_len => msg_len,
        msg_rst => msg_rst
    );
    
    main_proc: process
    begin

        sw <= passwd;
        bn <= "00";
        msg_finished <= '1';
        wait for 1000 ns;
        loop
            bn <= "00";
            wait for 1000 ns;
            
            bn <= "10";
            wait for 1000 ns;
            bn <= "01";
            wait for 1000 ns;
            bn <= "10"; 
            wait for 1000 ns;
            bn <= "01"; 
            wait for 1000 ns;
            
            bn <= "00";
            wait for 1000 ns;
            
            bn <= "10";
            wait for 1000 ns;
            bn <= "00";
            wait for 1000 ns;
            bn <= "10"; 
            wait for 1000 ns;
            bn <= "01";
            wait for 1000 ns; 
            
        end loop;
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
