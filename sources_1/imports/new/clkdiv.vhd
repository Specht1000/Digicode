library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clkdiv is
    generic ( 
        N : integer := 19
    );
    port (
        mclk : in std_logic;
        rst : in std_logic;
        clk190 : out std_logic
    );
end clkdiv;

architecture Behavioral of clkdiv is
    signal q : std_logic_vector(N-1 downto 0);
begin

    -- 100MHz / 2^N = 190,73 Hz
    -- Tclk190 = 1/190,73 = 5,24 ms
    -- 5,24 / 2 = 2.62 ms

    seq: process(mclk, rst) -- Contador de N-1 bits que apenas verifica o MSB
	begin
	    if rst = '1' then
	       q <= (others => '0');
	    elsif rising_edge(mclk) then
	       q <= q + 1;
	    end if;
	end process;
	
	clk190 <= q(N-1);
	
end Behavioral;
