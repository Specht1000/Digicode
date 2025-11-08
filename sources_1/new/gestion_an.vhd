library ieee;
use ieee.std_logic_1164.all;

entity gestion_an is
    port(
        rst : in  std_logic;
        entree : in  std_logic_vector(1 downto 0);
        sortie : out  std_logic_vector(3 downto 0)
    );
end gestion_an;

architecture Behavioral of gestion_an is
begin
    process(rst, entree) begin
        if rst = '1' then
            sortie <= (others => '1');
        else
            case entree is
                when "00" => sortie <= "0111";
                when "01" => sortie <= "1011";
                when "10" => sortie <= "1101";
                when "11" => sortie <= "1110";
                when others => sortie <= "1111";
            end case;
        end if;
    end process;

end Behavioral;
