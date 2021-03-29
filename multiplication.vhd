library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Multiplier_8 is
    Port ( X : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
           Y : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
           REZ : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)); 
end Multiplier_8;

architecture arch_of_multiplier of Multiplier_8 is	

component adder is 
	   port (Cin,A,B :in std_logic;
	   S,Cout:out std_logic);
   end   component;	

type arrayPP is array (0 to 6) of STD_LOGIC_VECTOR(6 downto 0);
type arrayS is array (0 to 6) of STD_LOGIC_VECTOR(7 downto 0);
type arrayT is array (0 to 5) of STD_LOGIC_VECTOR(7 downto 0);

SIGNAL PP : arrayPP;
SIGNAL S : arrayS;
SIGNAL T : arrayT;


begin
    GENPP1:  FOR I IN 0 TO 6 GENERATE
        GENPP2 : FOR J IN 0 TO 6 GENERATE 
            PP(I)(J) <= X(J) AND Y(I);
        END GENERATE;
    END GENERATE;
    
    InitS : FOR I IN 0 TO 6 GENERATE
            S(0)(I) <= PP(0)(I);
        END GENERATE;
        S(0)(7) <= '0';
        
        genT: FOR j IN 0 TO 5 GENERATE
            T(j)(0) <= '0';
        END GENERATE;
        
        gensum1: for i in 0 to 5 generate
            gensum2: for j in 0 to 6 generate
                sum_elem: adder port map(
                         S(i)(j+1),
                         PP(i+1)(j),
                         T(i)(j),
                         S(i+1)(j),
                         T(i)(j+1));
            end generate;
            S(i+1)(7) <= T(i)(6);
        end generate;   
    
        

genProd1: for i in 0 to 6 generate
    REZ(i) <= S(i)(0);
end generate;

genProd2: for i in 1 to 7 generate
    REZ(i+6) <= S(6)(i);
end generate; 
 
end arch_of_multiplier;
