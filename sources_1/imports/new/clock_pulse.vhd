library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clock_pulse is
     generic ( 
        N : integer := 3
     );
     port (
        clk : in std_logic;
        rst : in std_logic;
        entree : in std_logic;
        sortie : out std_logic
     );
end clock_pulse;

architecture Behavioral of clock_pulse is
    constant INIT : std_logic_vector(N-1 downto 0) := (others => '0');
    constant VALID : std_logic_vector(N-1 downto 0) := (0 => '0', others => '1'); -- 110
    signal q : std_logic_vector(N-1 downto 0);
    
    component shift_reg is
        generic ( 
            N : integer;
            INIT : std_logic_vector
        );
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            data_in : in std_logic;
            q : out std_logic_vector (N-1 downto 0)
        );
    end component;

begin
    shift_reg_1 : shift_reg
    generic map (
        N => N,
        INIT => INIT 
    ) port map (
        clk => clk,
        rst => rst,
        data_in => entree,
        q => q
    );
    
    comb: process(q) 
	begin
	    if q = VALID then
	       sortie <= '1';
	    else
	       sortie <= '0';
	    end if;
	end process;
    
end Behavioral;
