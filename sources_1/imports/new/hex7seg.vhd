library ieee;
use ieee.std_logic_1164.all;
    
entity hex7seg is
    port (
        hex: in std_logic_vector(3 downto 0);
        a_to_g: out std_logic_vector(6 downto 0)
    );
end hex7seg;

architecture Behavioral of hex7seg is
    
begin
    process (hex)
    begin
        case hex is
            when x"0" => a_to_g <="0000001"; -- 0 -- NB: O = ON , 1 = OFF
            when x"1" => a_to_g <="1001111"; -- 1 
            when x"2" => a_to_g <="0010010"; -- 2 
            when x"3" => a_to_g <="0101000"; -- k 
            when x"4" => a_to_g <="1100011"; -- u
            when x"5" => a_to_g <="1111010"; -- r
            when x"6" => a_to_g <="1110001"; -- l
            when x"7" => a_to_g <="1110000"; -- t 
            when x"8" => a_to_g <="1101010"; -- n
            when x"9" => a_to_g <="1100010"; -- o
            when x"A" => a_to_g <="0001000"; -- A 
            when x"B" => a_to_g <="1100000"; -- b 
            when x"C" => a_to_g <="0110001"; -- C 
            when x"D" => a_to_g <="1000010"; -- d 
            when x"E" => a_to_g <="0110000"; -- E 
            when others => a_to_g <= "1111111"; -- "1111111"; -- F
        end case; 
    end process;

end Behavioral;
