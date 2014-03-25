library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mpis.all;
 
ENTITY bcd_adder_single_test IS
END bcd_adder_single_test;
 
ARCHITECTURE behavior OF bcd_adder_single_test IS 
 
   --Inputs
   signal a : bcd_digit;
   signal b : bcd_digit;
   signal carry_in : std_logic := '0';
   signal EN : std_logic := '0';

 	--Outputs
   signal s : bcd_digit;
   signal carry_out : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.bcd_adder PORT MAP (
          a => a,
          b => b,
          s => s,
          carry_in => carry_in,
          carry_out => carry_out,
          EN => EN
        );
		  
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 10 ns;
		EN <= '1';
		carry_in <= '0';
		wait for 10 ns;
        for i1 in 0 to 9 loop
            for i0 in 0 to 9 loop
					a <= i0;
					b <= i1;
                wait for 10 ns;
            end loop;        
        end loop;
		  wait for 20 ns;
		  
		  carry_in <= '1';
		  wait for 20 ns;
		wait for 10 ns;
        for i1 in 0 to 9 loop
            for i0 in 0 to 9 loop
					a <= i0;
					b <= i1;
                wait for 10 ns;
            end loop;        
        end loop;
		  wait for 20 ns;
		  
      wait;
   end process;

END;
