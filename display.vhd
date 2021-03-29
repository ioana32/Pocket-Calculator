library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SSD is	--7 segments display
    Port ( digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           catod : out STD_LOGIC_VECTOR (6 downto 0);
           anod : out STD_LOGIC_VECTOR (3 downto 0));
end SSD;

architecture arch of SSD is

signal d: std_logic_vector(3 downto 0);
signal count:STD_LOGIC_VECTOR(15 downto 0);

begin

process(d)
begin
    case d is
        when "0001" => catod <= "1111001" ;   --1
        when "0010" => catod <= "0100100" ;   --2
        when "0011" => catod <= "0110000" ;   --3
        when "0100" => catod <= "0011001" ;   --4
        when "0101" => catod <= "0010010" ;   --5
        when "0110" => catod <= "0000010" ;   --6
        when "0111" => catod <= "1111000" ;   --7
        when "1000" => catod <= "0000000" ;   --8
        when "1001" => catod <= "0010000" ;   --9
        when "1010" => catod <= "0001000" ;   --A
        when "1011" => catod <= "0000011" ;   --b
        when "1100" => catod <= "1000110" ;   --C
        when "1101" => catod <= "0100001" ;   --d
        when "1110" => catod <= "0000110" ;   --E
        when "1111" => catod <= "0001110" ;   --F
        when others => catod <= "1000000" ;   --0
    end case;
end process;

process(clk)
    begin
        if (clk='1' and clk'event) then -- if rising_edge(clk) then
               count <= count+1;
        end if;
end process;

process(count(15 downto 14))
    begin
        case count(15 downto 14) is
            when "00" => anod <= "1110";
            when "01" => anod <= "1101";
            when "10" => anod <= "1011";
            when others => anod <= "0111";
            end case;
end process;

process(count(15 downto 14),digit0,digit1,digit2,digit3)
    begin
        case count(15 downto 14) is
            when "00" => d <= digit0;
            when "01" => d <= digit1;
            when "10" => d <= digit2;
            when others => d <= digit3;
            end case;
end process;

end architecture;
