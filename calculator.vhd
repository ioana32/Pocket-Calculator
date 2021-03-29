						
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Calculator is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           btn : in STD_LOGIC_VECTOR (3 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end Calculator;

architecture Behavioral of Calculator is
component ALU is 			
	port (
    NR1:in std_logic_vector(7 downto 0);	
	NR2:in std_logic_vector(7 downto 0); 
	Sel : in std_logic_vector(1 downto 0);
	Rez: out std_logic_vector(15 downto 0)); 
end component ALU;

component SSD is	--7 segments display
    Port ( digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           catod : out STD_LOGIC_VECTOR (6 downto 0);
           anod : out STD_LOGIC_VECTOR (3 downto 0));
end component SSD;

signal NR1, NR2 : std_logic_vector(7 downto 0) := x"00";
signal REZ : std_logic_vector(15 downto 0) := x"0000";
signal DIGIT0, DIGIT1, DIGIT2, DIGIT3 : std_logic_vector(3 downto 0) := "0000";
signal sel : std_logic_vector(1 downto 0) := "00";

begin

process(btn, sel)
begin
    if (btn(0) = '1') then
        sel <= "00";
    end if;
    if (btn(1) = '1') then
        sel <= "01";
    end if;
    if (btn(2) = '1') then
       sel <= "10";
    end if;
    if (btn(3) = '1') then
       sel <= "11";
    end if;
    --REZ <= x"0000";
end process;

NR1 <= sw(15 downto 8);
NR2 <= sw(7 downto 0);

ALU1: ALU port map (NR1 => NR1, NR2 => NR2, sel => sel, REZ => REZ);
display: SSD port map (digit0 => REZ(3 downto 0),
                        digit1 => REZ(7 downto 4),
                        digit2 => REZ(11 downto 8), 
                        digit3 => REZ(15 downto 12),
                        clk => clk, 
                        catod => cat, 
                        anod => an);
led <= sw;
end Behavioral;

