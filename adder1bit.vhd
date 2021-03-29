 library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   
   entity adder is 
	   port (Cin,A,B :in std_logic;
	   S,Cout:out std_logic);
   end   entity adder;
   
   architecture arch of adder is
   signal s1,s2,s3: std_logic;
   begin 	   
	   S<=A xor B xor Cin; 
	   s1<=A and B;
	   s2<=B and Cin;
	   s3<=A and Cin;
	   Cout<=s1 or s2 or s3;
	end architecture arch;	   