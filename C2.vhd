library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity C2 is
	port (inside : in std_logic_vector(15 downto 0);
	outside : out std_logic_vector (15 downto 0));
end C2;

architecture arch of C2 is 
begin	
	process(inside)
	variable temp : std_logic_vector(15 downto 0);
  begin
      temp:=inside;
 
		e1:for i in 0 to 14 loop
		temp(i):= (inside(i) xor inside(15));	 
	end loop;
	temp:=temp+inside(15);
	outside<=temp;   
	end process;

end architecture arch;
