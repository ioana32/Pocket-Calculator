

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;	
use ieee.std_logic_arith.all;


entity conversie is
    Port ( H : in STD_LOGIC_VECTOR (15 downto 0);
           D : out STD_LOGIC_VECTOR (15 downto 0);
           S : out STD_LOGIC);
end conversie;

architecture arch of conversie is
component BCD is
	port (A:IN STD_LOGIC_VECTOR(15 downto 0);
		P:out std_logic_vector(15 downto 0));
end component BCD;

signal A1,P1:std_logic_vector(15 downto 0):=x"0000";
begin

process(H,A1,P1)
begin
    if (H(15) = '1') then
        A1 <= not(H) + '1';
        S <= '1';
    else
        A1 <= H;
        S <= '0';
    end if;
end process;

D <= P1;
Decimal: BCD port map (A=>A1,P=>P1);
end arch;