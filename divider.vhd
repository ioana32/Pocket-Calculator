library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;	


entity divider is 			
	port (
    A:in std_logic_vector(7 downto 0);	
	B:in std_logic_vector(7 downto 0);  
	Q:out std_logic_vector(7 downto 0)); 
end divider; 

architecture arh of divider is 
signal Q1: std_logic_vector(7 downto 0):="00000000"; 
begin 
		process(A , B)
			variable a1:std_logic_vector(7 downto 0):="00000000";
			variable b1:std_logic_vector(7 downto 0):="00000000";
			variable contor:std_logic_vector(7 downto 0):="00000000";		
		begin						
			a1 := A;
			b1 := B;
			if (b1 = "00000000") then
				Q <= "00000000";
			else
			    for i in 0 to 500 loop
			         if ( a1 >= b1) then
			             a1 := a1 - b1;
			             contor := contor + "00000001";
			         end if;
			    end loop;
			--	while (a1 >= b1) loop 
			--		a1 := a1 - b1;
			--		contor := contor + "00000001";	
			--end loop;
			end if;
			
			Q <= contor;
			contor(7 downto 0):="00000000";
	end process;	
end arh;	   
			
			
		
