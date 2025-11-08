library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity digicode_control is
    port (
        clk : in std_logic;
        rst : in std_logic;
        sw : in std_logic_vector(7 downto 0);
        bn : in std_logic_vector(1 downto 0);
        ld : out std_logic_vector(1 downto 0);
        en : out std_logic_vector(3 downto 0);
        
        msg_finished : in std_logic;
        msg : out std_logic_vector(63 downto 0);
        msg_len : out std_logic_vector(3 downto 0); 
        msg_rst : out std_logic
    );
end digicode_control;

architecture Behavioral of digicode_control is
    type etat_t is (INIT, SHOW_MSG, S1, S2, S3,S4, PASS, ER1, ER2, ER3, FAIL);
    
    
    constant INIT_MSG : std_logic_vector(63 downto 0)  := x"FFE875E56EC9DEFF"; -- ENTRER LE CODE

    constant INIT_MSG_LEN : std_logic_vector(3 downto 0) := "1111";
    
    constant PASS_MSG : std_logic_vector(63 downto 0) := x"FF03FFFFFFFFFFFF"; -- OK
    constant PASS_MSG_LEN : std_logic_vector(3 downto 0) := "0100";
    
    constant FAIL_MSG : std_logic_vector(63 downto 0) := x"FFE55E45FFFFFFFF"; -- ERREUR
    constant FAIL_MSG_LEN : std_logic_vector(3 downto 0) := "1000";
    
	signal etat, next_etat : etat_t;
	signal passed, failed : std_logic := '0';
begin
    
    msg_rst <= (clk and msg_finished) or rst;
    
    seq: process(clk, rst) 
	begin
	    if rst = '1' then
	       etat <= INIT;
	    elsif rising_edge(clk) then
	       if msg_finished = '1' then
		        etat <= next_etat;
			end if;
		end if;
	end process;
	
	combi: process(etat, bn, sw) -- TODO
    begin
        case etat is 
            when INIT =>
                ld <= "00";
                en <= x"0";
                
                msg <= INIT_MSG;
	            msg_len <= "0000";
	            
                next_etat <= SHOW_MSG;
                
			when SHOW_MSG =>
                ld <= "00";
                en <= x"0";
                
                msg <= INIT_MSG;
	            msg_len <= INIT_MSG_LEN;
				failed <= '0';
				passed <= '0';
	            if bn = sw(7 downto 6) then
                    next_etat <= S1;
                else
                    next_etat <= ER1;
                end if; 
                
            when S1 => 
		        ld <= "00";
		        en <= x"1";
		        failed <= '0';
				passed <= '0';
		        msg <= INIT_MSG;
		        msg_len <= "0000";
		        
			    if bn = sw(5 downto 4) then
                    next_etat <= S2;
                else
                    next_etat <= ER2;
                end if;
			         
            when S2 => 
			    ld <= "00";
			    en <= x"2";
			    failed <= '0';
				passed <= '0';
			    msg <= INIT_MSG;
		        msg_len <= "0000";
		        
				if bn = sw(3 downto 2) then
                    next_etat <= S3;
                else
                    next_etat <= ER3;
                end if;
                
    		when S3 =>
    		    ld <= "00"; 
    		    en <= x"3";
    		    
    		    msg <= INIT_MSG;
		        msg_len <= "0000";
		        failed <= '0';
		        passed <= '0';
    	        if bn = sw(1 downto 0) then
    	            passed <= '1';
    	            failed <= '0';
                    next_etat <= S4;
                else
                    failed <= '1';
                    passed <= '0';
                    next_etat <= S4;
                end if;
            when S4 =>
				ld <= "00";
				en <= x"4";

                msg <= INIT_MSG;
			    msg_len <= "0000";

				if passed = '1' then
					next_etat <= PASS;
				elsif failed = '1' then
					next_etat <= FAIL;
				end if;

			when PASS =>
			    ld <= "10";
			    en <= x"0";
			    passed <= '0';
				failed <= '0';
			    msg <= PASS_MSG;
	            msg_len <= PASS_MSG_LEN;
	            
			    next_etat <= SHOW_MSG;
                
		    when ER1 =>
		        ld <= "00";
		        en <= x"1";
		        
		        msg <= INIT_MSG;
		        msg_len <= "0000";
		        passed <= '0';
				failed <= '1';
		        next_etat <= ER2;
		        
		    when ER2 =>
		        ld <= "00";
		        en <= x"2";
		        
		        msg <= INIT_MSG;
		        msg_len <= "0000";
		        passed <= '0';
				failed <= '1';
		        next_etat <= ER3;
		    
		    when ER3 =>
		        ld <= "00";
		        en <= x"3";
		        
		        msg <= INIT_MSG;
		        msg_len <= "0000";
		        passed <= '0';
				failed <= '1';
				next_etat <= S4;


		    when FAIL =>
		        ld <= "01";
		        en <= x"0";
		        passed <= '0';
				failed <= '0';
		        msg <= FAIL_MSG;
	            msg_len <= FAIL_MSG_LEN;
	            
		        next_etat <= SHOW_MSG;

         end case;
    end process;
end Behavioral;