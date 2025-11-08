library ieee;
use ieee.std_logic_1164.all;

entity mux is
    port (
        sel : in std_logic_vector(1 downto 0);
        e1,e2,e3,e4 : in std_logic_vector(3 downto 0);
        sortie : out std_logic_vector(3 downto 0)
    );
end mux;

architecture Behavioral of mux is

begin

    combi: process(sel)
    begin
        case sel is
            when "00" => sortie <= e1;
            when "01" => sortie <= e2;
            when "10" => sortie <= e3;
            when "11" => sortie <= e4;
            when others => sortie <= "0000";
        end case;
    end process;
    
end Behavioral;