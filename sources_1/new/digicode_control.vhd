library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digicode_control is
    port (
         rst, clk : in std_logic;
         bn : in std_logic_vector(1 downto 0);
         sw : in std_logic_vector(7 downto 0);
         led : out std_logic_vector(1 downto 0);
         en : out std_logic_vector(3 downto 0) );
end digicode_control;

architecture behavioral of digicode_control is
    type FSM_State is (S0, S1, S2, S3, S4, E1, E2, E3, E4);
    signal State, NextState : FSM_State;
    
    begin

    clk_proc: process(clk, rst) begin
        if rst = '1' then
            State <= S0;
        elsif rising_edge(clk) then
            State <= NextState;
        end if;
    end process;
    
    MEF: process(State, sw, bn) begin
            case State is
                when S0 =>
                    if bn = sw(7 downto 6) then
                        NextState <= S1;
                        en <= "0001";
                    else
                        NextState <= E1;
                    end if;
                when S1 =>
                    if bn = sw(5 downto 4) then
                        en <= "0010"; 
                        NextState <= S2;
                    else
                        NextState <= E2;
                    end if;
                when S2 => 
                    if bn = sw(3 downto 2)then
                        en <= "0100";
                        NextState <= S3;
                    else
                        NextState <= E3;
                    end if;
                when S3 =>
                    if bn = sw(1 downto 0) then
                        en <= "1000";
                        NextState <= S4;
                    else 
                        NextState <= E4;
                    end if;
                when S4 =>
                    if bn = sw(7 downto 6) then
                        en <= "0001";
                        NextState <= S1;
                    else 
                        NextState <= E1;
                    end if;
                 when E1 =>
                    en <= "0010";
                    NextState <= E2;
                 when E2 =>
                    en <= "0100";
                    NextState <= E3;
                 when E3 =>
                    en <= "1000";
                    NextState <= E4;
                 when E4 =>
                    en <= "0001";
                    if bn = sw(7 downto 6) then
                        NextState <= S1;
                    else
                        NextState <= E1;
                    end if;   
            end case;
    end process;
    
    led(1) <= '1' when State = S4 else '0';
    led(0) <= '1' when State = E4 else '0';

end behavioral;