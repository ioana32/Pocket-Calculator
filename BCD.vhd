library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;  

entity BCD is
	port (A:IN STD_LOGIC_VECTOR(15 downto 0);
		P:out std_logic_vector(15 downto 0)
	);
end entity;

architecture ARCH of BCD is	

signal binary: std_logic_vector (9 downto 0):= "0000000000";
signal P1: std_logic_vector(15 downto 0):=x"0000";
begin	

binary <= A(9 downto 0);		   
process(A,binary) 
variable unitati: std_logic_vector (3 downto 0):="0000";
variable zeci: std_logic_vector (3 downto 0):="0000";	
variable sute: std_logic_vector (3 downto 0):="0000";

	begin 
		for i in 9 downto 0 loop
			if (sute >= 5) then 
				sute:=sute+3;
			end if;
			
			if (zeci >= 5) then 
				zeci:=zeci+3;
			end if;	 
			
			if (unitati >= 5) then 
				unitati:=unitati+3;
			end if;	
			
			sute(3):=sute(2);
			sute(2):=sute(1);
			sute(1):=sute(0);
			sute(0):=zeci(3);
			
			zeci(3):=zeci(2);
			zeci(2):=zeci(1);
			zeci(1):=zeci(0);
			zeci(0):=unitati(3);
			
			unitati(3):=unitati(2);
			unitati(2):=unitati(1);
			unitati(1):=unitati(0);
			unitati(0):=binary(i);
		end loop;  
		P1 <= "0000" & sute & zeci & unitati;
		
	end process;
	   P <= P1;
end architecture;