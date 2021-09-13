library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mult is
	 generic ( k : integer := 521);
    Port ( A : in  std_logic_vector(k-1 downto 0);
           B : in  std_logic_vector(k-1 downto 0);
           C : out  std_logic_vector(k-1 downto 0);
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  start: in  STD_LOGIC;
			  done : out  STD_LOGIC
			  );
end mult;

architecture Behavioral of mult is
constant P: std_logic_vector(k+1 downto 0):="001"&x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"; --for 256 bit
constant P2: std_logic_vector(k+1 downto 0):="011"&x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE"; --for 256 bit
signal temp2,temp3, temp4: std_logic_vector(k+1 downto 0);
signal prod, prod1, prod2, prod3, prod4: std_logic_vector(k+1 downto 0);
signal temp1: std_logic_vector(k-1 downto 0);

signal sel: std_logic_vector(1 downto 0);

signal first: std_logic;
 
begin
 
with temp1(0) select
		prod1 <= prod + temp2 when '1',
						prod when others;


prod2<=prod1-P;
prod3<=prod1-P2;
sel<=prod2(k+1)&prod3(k+1);
with sel select
		prod4 <= prod1 when "11",
		         prod2 when "01",
					prod3 when others;
 
with temp2(k) select
		temp4 <= temp2 when '0',
					temp2-P when others;
 
process(CLK, reset, start)

begin
	if reset = '1' then
		first <= '1';
		done <= '0';
		           C <= '0'&x"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

		 
	elsif (CLK'event and CLK = '1' and start= '1')  then
		if first = '1' then
			temp1 <= B;
			temp2 <= "00" & A;

			prod <= (others => '0');
			first <= '0';
		else
			if temp1 =0 then
				C <= prod4(k-1 downto 0);	
				done <= '1';
			else
			
	
			
				temp2 <= temp4(k downto 0) & '0';
				temp1 <= '0' & temp1(k-1 downto 1);
				prod <= prod4;
			end if;
		end if;
	end if;
end process;
end Behavioral;


