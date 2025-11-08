library ieee;
use ieee.std_logic_1164.all;

entity basys3 is
    port (
        clk : in std_logic;
        sw : in std_logic_vector(7 downto 0);
        led : out std_logic_vector(1 downto 0);
        btnL, btnC, btnR, btnD : in std_logic;
        seg : out std_logic_vector(0 to 6);
        dp : out std_logic;
        an : out std_logic_vector(0 to 3)
    );
end basys3;

architecture Behavioral of basys3 is
    signal btn : std_logic_vector(3 downto 0);
    
    component digicode_top is
        port (
            mclk : in std_logic;
            btn : in std_logic_vector(3 downto 0);
            sw : in std_logic_vector(7 downto 0);
            ld : out std_logic_vector(1 downto 0);
            a_to_g: out std_logic_vector(0 to 6);
            ans: out std_logic_vector(3 downto 0)
        );
    end component;
    
begin
    
    digicode_top_1: digicode_top
    port map (
        mclk => clk,
        btn => btn,
        sw => sw,
        ld => led,
        a_to_g => seg,
        ans => an
    );
    
    btn(0) <= btnL; 
    btn(1) <= btnC; 
    btn(2) <= btnR;
    btn(3) <= btnD;  
    
    dp <= '1';
    
end Behavioral;
