library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux_tb is
end mux_tb;

architecture Behavioral of mux_tb is
    signal sel : std_logic_vector(1 downto 0);
    signal sortie : std_logic_vector(3 downto 0);
    signal e1,e2,e3,e4 : std_logic_vector(3 downto 0);
begin
    
    mux_1: entity work.mux
    port map (sel => sel,sortie => sortie, e1=>e1, e2=>e2, e3=>e3, e4=>e4 );
    
    e1 <= x"1";
    e2 <= x"2";
    e3 <= x"3";
    e4 <= x"4";
    
    count_proc: process
    begin
        sel <= "00";
        wait for 20 ns;
        loop
            sel <= sel + 1;
            wait for 10 ns;    
        end loop;
    end process;
    
    
end Behavioral;
