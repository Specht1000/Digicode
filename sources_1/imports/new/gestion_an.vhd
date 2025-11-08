library ieee;
use ieee.std_logic_1164.all;

entity gestion_an is
    port (
        clk : in std_logic;
        rst : in std_logic;
        count : in std_logic_vector(1 downto 0);
        ans : out std_logic_vector(3 downto 0)
    );
end gestion_an;

architecture Behavioral of gestion_an is

begin
    
    comb: process(count) 
    begin
        case count is
            when "00" => ans <= "1110";
            when "01" => ans <= "1101";
            when "10" => ans <= "1011";
            when "11" => ans <= "0111";
            when others => ans <= "1111";
        end case;
	end process;

end Behavioral;