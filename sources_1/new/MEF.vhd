library ieee;
use ieee.std_logic_1164.all;

entity MEF is
    port(
        rst, clk : in  std_logic;
        en : out std_logic_vector(3 downto 0);
        btn : in  std_logic_vector(3 downto 0)
    );
end MEF;

architecture Behavioral of MEF is
    signal btn012, clk_out_pulse : std_logic;
    type FSM_State is (E1, E2, E3, E4);
    signal State, NextState : FSM_State;
begin
    btn012 <= btn(0) or btn(1) or btn(2);

    clk_pulse_inst : entity work.clock_pulse
        port map (
            clk_in_pulse => clk,
            rst => rst,
            btn012 => btn012,
            pulse => clk_out_pulse
        );

    process(clk, rst)
    begin
        if rst = '1' then
            State <= E1;
        elsif rising_edge(clk) then
            if clk_out_pulse = '1' then
                State <= NextState;
            end if;
        end if;
    end process;

    process(State)
    begin
        case State is
            when E1 => NextState <= E2;
            when E2 => NextState <= E3;
            when E3 => NextState <= E4;
            when E4 => NextState <= E1;
        end case;
    end process;

    en <= "0000" when clk_out_pulse = '0' else
          "0001" when State = E1 else
          "0010" when State = E2 else
          "0100" when State = E3 else
          "1000";
          
end Behavioral;
