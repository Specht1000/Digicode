library ieee;
use ieee.std_logic_1164.all;

entity reg_saisie is
    port (
        clk : in std_logic;
        rst : in std_logic;
        en : in std_logic_vector(3 downto 0);
        btn : in std_logic_vector(2 downto 0);
        e1, e2, e3, e4 : out std_logic_vector(3 downto 0)
    );
end reg_saisie;

architecture Behavioral of reg_saisie is
    type reg_data_t is array (3 downto 0) of std_logic_vector(3 downto 0);
    
    signal reg_data : reg_data_t;
    signal digit : std_logic_vector(3 downto 0);
begin

    reg_data_seq: process(clk, rst) 
	begin
        if rst = '1' then
            reg_data(0) <= x"F";
            reg_data(1) <= x"F";
            reg_data(2) <= x"F";
            reg_data(3) <= x"F";
        elsif rising_edge(clk) then
            reg_data(3) <= digit;
            reg_data(2 downto 0) <= reg_data(3 downto 1);    
        end if;
	end process;
	
	digit_combi: process(btn)
	begin
	   case btn is
            when "001" => digit <= x"0";
            when "010" => digit <= x"1";
            when "100" => digit <= x"2";
            when others => digit <= x"F";
        end case;
	end process;
	
	e_combi: process(en, reg_data)
	begin
	   case en is
            when x"0" =>
                e1 <= x"F";
                e2 <= x"F";
                e3 <= x"F";
                e4 <= x"F";
               
            when x"1" =>
                e1 <= x"F";
                e2 <= x"F";
                e3 <= x"F";
                e4 <= reg_data(3);
                
            when x"2" =>
                e1 <= x"F";
                e2 <= x"F";
                e3 <= reg_data(2);
                e4 <= reg_data(3);
            
            when x"3" =>
                e1 <= x"F";
                e2 <= reg_data(1);
                e3 <= reg_data(2);
                e4 <= reg_data(3);
                
            when x"4" =>
                e1 <= reg_data(0);
                e2 <= reg_data(1);
                e3 <= reg_data(2);
                e4 <= reg_data(3);
                
            when others =>
                e1 <= x"F";
                e2 <= x"F";
                e3 <= x"F";
                e4 <= x"F";
        end case;   
	end process;
	
end Behavioral;