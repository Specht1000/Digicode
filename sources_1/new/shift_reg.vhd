library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
    generic ( 
        N : integer := 4;
        INIT : std_logic_vector := "0000"
    );    
    port ( 
        clk : in std_logic;
        rst : in std_logic;
        data_in : in std_logic;
        q : out std_logic_vector (N-1 downto 0)
    );
end shift_reg;

architecture Behavioral of shift_reg is
    signal qs : std_logic_vector(N-1 downto 0); 
begin

    process(clk, rst)
    begin
        if rst='1' then qs <= INIT;
        elsif rising_edge(clk) then
            qs(N-1) <= data_in;
            qs(N-2 downto 0) <= qs(N-1 downto 1);
        end if;
    end process;
    
    q <= qs;
    
end Behavioral;
