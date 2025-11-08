library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clkdiv_3Hz is
    generic ( 
        N : integer := 6
    );
    port (
        mclk   : in  std_logic;
        rst    : in  std_logic;
        clk3hz : out std_logic
    );
end clkdiv_3Hz;

architecture Behavioral of clkdiv_3Hz is
    signal q : std_logic_vector(N-1 downto 0);
begin

    -- 190 Hz / 2^6 = 2.97 Hz
    -- Tclk3hz ≈ 0.337 s → meio período ≈ 0.168 s

    process(mclk, rst)
    begin
        if rst = '1' then
            q <= (others => '0');
        elsif rising_edge(mclk) then
            q <= q + 1;
        end if;
    end process;
    
    clk3hz <= q(N-1);

end Behavioral;
