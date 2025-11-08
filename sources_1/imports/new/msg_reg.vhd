library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity msg_reg is
    port (
        clk : in std_logic;
        rst : in std_logic;
        msg : in std_logic_vector(63 downto 0);
        len : in std_logic_vector(3 downto 0);
        finished : out std_logic;
        a1, a2, a3, a4 : in std_logic_vector(3 downto 0);
        e1, e2, e3, e4 : out std_logic_vector(3 downto 0)
    );
end msg_reg;

architecture Behavioral of msg_reg is
    signal mem : std_logic_vector(63 downto 0);
    signal count : std_logic_vector(3 downto 0);
begin
    
    seq: process(clk, rst) 
	begin
	    if rst = '1' then
            mem <= msg;
            count <= len;
	    elsif rising_edge(clk) then 
            for I in 14 downto 0 loop
                mem(7+I*4 downto 4+I*4) <= mem(3+I*4 downto 0+I*4);
            end loop;
            
            mem(3 downto 0) <= x"F";
            
            if count > 0 then
                count <= count - 1;
            end if;
	    end if;
	end process;
	
	comb: process(count) 
	begin
        if count = 0 then
            e1 <= a1;
            e2 <= a2;
            e3 <= a3;
            e4 <= a4;
            finished <= '1';
	    else
            e1 <= mem(63 downto 60);
            e2 <= mem(59 downto 56);
            e3 <= mem(55 downto 52);
            e4 <= mem(51 downto 48);
            finished <= '0';
	    end if;
	end process;
end Behavioral;