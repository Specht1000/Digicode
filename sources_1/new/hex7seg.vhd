library ieee;
use ieee.std_logic_1164.all;

entity hex7seg is
    port(
        clk : in  std_logic;
        rst : in  std_logic;
        bin : in  std_logic_vector(3 downto 0);
        a_to_g : out std_logic_vector(6 downto 0)
    );
end hex7seg;

architecture Behavioral of hex7seg is
begin
process(bin)
begin
    case bin is      
        when "0000" => a_to_g <= "0000001"; -- 0
        when "0001" => a_to_g <= "1001111"; -- 1
        when "0010" => a_to_g <= "0010010"; -- 2
        when "0011" => a_to_g <= "0001000"; -- A
        when "0100" => a_to_g <= "1111010"; -- r
        when "0101" => a_to_g <= "0110001"; -- C
        when "0110" => a_to_g <= "0101000"; -- k
        when "0111" => a_to_g <= "1111001"; -- I
        when "1000" => a_to_g <= "1110000"; -- T
        when "1001" => a_to_g <= "0110000"; -- E
        when "1010" => a_to_g <= "1000001"; -- U
        when "1011" => a_to_g <= "1101010"; -- n
        when "1100" => a_to_g <= "1110001"; -- L
        when "1101" => a_to_g <= "0100001"; -- G
        when "1111" => a_to_g <= "1111111"; -- 
        when others => a_to_g <= "1111111"; -- off
    end case;
end process;

end Behavioral;
