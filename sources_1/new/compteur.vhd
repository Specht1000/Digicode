library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity compteur is
    port (
        clk : in std_logic;
        rst : in std_logic;
        sortie: out std_logic_vector(1 downto 0)
    );
end compteur;

architecture Behavioral of compteur is
    signal count : std_logic_vector(1 downto 0);
begin

    seq: process(clk, rst) 
	begin
	    if rst = '1' then
	       count <= "11";
	    elsif rising_edge(clk) then
	       count <= count + 1;
	    end if;
	end process;
    
    sortie <= count;
    
end Behavioral;
