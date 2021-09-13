
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
library std;
use std.textio.all; --include package textio.vhd
 
ENTITY TB_mult IS
END TB_mult;
 
ARCHITECTURE behavior OF TB_mult IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mult
    PORT(
         A : IN  std_logic_vector(520 downto 0);
         B : IN  std_logic_vector(520 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         done : OUT  std_logic;
         C : OUT  std_logic_vector(520 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(520 downto 0) := (others => '0');
   signal B : std_logic_vector(520 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs
   signal done : std_logic;
   signal C : std_logic_vector(520 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mult PORT MAP (
          A => A,
          B => B,
          clk => clk,
          reset => reset,
          start => start,
          done => done,
          C => C
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
 

-- Stimulus process
   stim_proc: process
	file file1: text;
	variable fstatus : File_open_status;
	variable buff : line;
	
   begin		
    file_open (fstatus, file1, "TB_mod_mult_new.txt",write_mode);
	 
      reset <= '1';	
      wait for clk_period;
      reset <= '0';
		start <= '1';

--		
	  A <= '1'&x"8D0B1C0D6E0809D39B3C7D96CC472B688538C902720A7F6A43F0515EC0D69A7B754296BCEFDFCEB251FC3B824F45FF51BC669167830AD48537F2FCFC6385CB7ACC";
      B <= '1'&x"1839296a789a3bc0045c8a5fb42c7d1bd998f54449579b446817afbd17273e662c97ee72995ef42640c550b9013fad0761353c7086a272c24088be94769fd16650";
		
--		X1 <= x"216936D3CD6E53FEC0A4E231FDD6DC5C692CC7609525A7B2C9562D608F25D51A";
--		Y1 <= x"6666666666666666666666666666666666666666666666666666666666666658"; --1px,y,z
--		Z1 <= x"0000000000000000000000000000000000000000000000000000000000000001";
--		
--
--		
--		X2 <=x"31241DDB9A7C254AEA224B87B7B0F909886EC1DDFA71625B7ABA864C18300A57";
--      Y2 <=x"3324984C6CC933DB69B782FC3AC951F60A47AA662BBE321C924B2CD95E2D7FD7";
--      Z2 <=x"6986C5796B577C574098BEFA3B426292EBD360FDD39299D16374A93CEF78DE6B";
		
		wait for clk_period;
		
		
		write (buff, string '("A="));
      write (buff, A);
		writeline (file1, buff);
		
		write (buff, string '("B="));
      write (buff, B);
		writeline (file1, buff);
				
      wait for 200 ns;
		
		write (buff, string '("C="));
      write (buff, C);
		writeline (file1, buff);
		
      wait;
   end process;	

END;




 