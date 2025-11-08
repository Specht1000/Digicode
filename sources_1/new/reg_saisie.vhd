library ieee;
use ieee.std_logic_1164.all;

entity reg_saisie is
    port(
        rst, clk, clk190 : in  std_logic;
        en : in  std_logic_vector(3 downto 0);
        btn : in  std_logic_vector(1 downto 0);
        s1, s2, s3, s4 : out std_logic_vector(3 downto 0);
        msg : in std_logic_vector(1 downto 0)
    );
end reg_saisie;

architecture Behavioral of reg_saisie is
    signal reg1, reg2, reg3, reg4 : std_logic_vector(3 downto 0);
    signal reg1_msg, reg2_msg, reg3_msg, reg4_msg : std_logic_vector(3 downto 0);
    signal clock_3hz, start: std_logic;
    signal reg56 : std_logic_vector(55 downto 0);
    signal reg16 : std_logic_vector(15 downto 0);
    signal reg24 : std_logic_vector(23 downto 0);
    signal counter_arch_FPGA : std_logic_vector(4 downto 0);
begin

    clk3: entity work.clkdiv_3hz
        port map(
            mclk => clk190,
            rst    => rst,
            clk3hz => clock_3hz
        );
 
    process(clk, rst)
    begin
        if rst = '1' then
            reg1 <= "1111";
            reg2 <= "1111";
            reg3 <= "1111";
            reg4 <= "1111";
            start <= '0';
        elsif rising_edge(clk) then
            start <= '1';
            if en = "0001" then
                reg1 <= "00" & btn;
                reg2 <= "1111";
                reg3 <= "1111";
                reg4 <= "1111";
            elsif en = "0010" then
                reg2 <= "00" & btn;
                reg3 <= "1111";
                reg4 <= "1111";
            elsif en = "0100" then
                reg3 <= "00" & btn;
                reg4 <= "1111";
            elsif en = "1000" then
                reg4 <= "00" & btn;
            end if;
        end if;
    end process;
    
    process(clock_3hz, rst)
    begin
        if rst = '1' then
            reg56 <=
                "1001" & -- E
                "1011" & -- N
                "1000" & -- T
                "0100" & -- R
                "1001" & -- E
                "0100" & -- R
                "1111" & -- 
                "1100" & -- L
                "1001" & -- E
                "1111" & -- 
                "0101" & -- C
                "0000" & -- O
                "0000" & -- D
                "1001"; -- E
                
            reg24 <= 
                "1001" & -- E
                "0100" & -- R
                "0100" & -- R
                "1001" & -- E
                "1010" & -- U
                "0100" ;-- R
                
            reg16 <= 
                "0000" & -- O
                "0110" & -- K
                "1111" &
                "1111";
                
            reg1_msg <= "1111";
            reg2_msg <= "1111";
            reg3_msg <= "1111";
            reg4_msg <= "1111";

        elsif rising_edge(clock_3hz) then
            if msg = "00" then -- entrer le code
                reg1_msg <= reg56(55 downto 52);
                reg2_msg <= reg56(51 downto 48);
                reg3_msg <= reg56(47 downto 44);
                reg4_msg <= reg56(43 downto 40);
            elsif msg = "01" then -- erreur
                reg1_msg <= reg24(23 downto 20);
                reg2_msg <= reg24(19 downto 16);
                reg3_msg <= reg24(15 downto 12);
                reg4_msg <= reg24(11 downto 8);
            elsif msg = "10" then -- ok
                reg1_msg <= reg16(15 downto 12);
                reg2_msg <= reg16(11 downto 8);
                reg3_msg <= reg16(7 downto 4);
                reg4_msg <= reg16(3 downto 0);
            end if;

            reg56 <= reg56(51 downto 0) & "1111";
            if msg = "01" then
                reg24 <= reg24(19 downto 0) & "1111";
            else
                reg24 <= 
                    "1001" & -- E
                    "0100" & -- R
                    "0100" & -- R
                    "1001" & -- E
                    "1010" & -- U
                    "0100" ; -- R
            end if;
        end if;
    end process;

    s1 <= reg1_msg when (start = '0' or msg /= "00") else reg1;
    s2 <= reg2_msg when (start = '0' or msg /= "00") else reg2;
    s3 <= reg3_msg when (start = '0' or msg /= "00") else reg3;
    s4 <= reg4_msg when (start = '0' or msg /= "00") else reg4;

end Behavioral;
