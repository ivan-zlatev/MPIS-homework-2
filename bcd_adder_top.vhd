library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mpis.all

entity bcd_adder_top is
	generic( N: positive := 3);
	port(	
		a, b: in bcd_number(N-1 downto 0); -- 3 digits input
		s: out bcd_number(N downto 0); -- 4 digit output
		carry_in: in std_logic; -- carry in
		carry_out: out std_logic; -- carry out
		EN: in std_logic); -- enable signal
end bcd_adder_top;

architecture arch1 of bcd_adder_top is
	-- signals
	signal temp: bcd_number(N downto 0);
	signal carry: std_logic_vector(N-1 downto 0);
begin
-- generate first and last digit adder
Ix: for i in 1 to N generate
	begin
	-- generate the lowest digit adder if N > 1
	I0 : if (i = 1 and i < N) generate
		begin U0: entity work.bcd_adder port map(
			a => a(i-1),
			b => b(i-1),
			s => temp(i-1),
			carry_in => carry_in,
			carry_out => carry(i-1),
			EN => EN);
	end generate I0;

	-- generate the highest digit adder if N > 1
	IL : if (i = N and i > 1) generate
		begin UL: entity work.bcd_adder port map(
			a => a(i-1),
			b => b(i-1),
			s => temp(i-1),
			carry_in => carry(i-2),
			carry_out => carry(i-1),
			EN => EN);
	end generate IL;

	-- generate the only digit adder if N = 1
	instance : if ( i = 1 and i = N) generate
		begin U: entity work.bcd_adder port map(
			a => a,
			b => b,
			s => temp(i-1),
			carry_in => carry_in,
			carry_out => carry(i-1),
			EN => EN);
	end generate instance;
end generate Ix;

--generate middle digits adders if N > 2
Iy: for j in 2 to N generate
	begin
	I : if (j > 1 and j < N) generate
		begin Ux: entity work.bcd_counter port map(
			a => a(j-1),
			b => b(j-1),
			s => temp(j-1)m
			carry_in => carry(j-2),
			carry_out => carry(j-1),
			EN => EN);
	end generate I;
end generate Iy;
s <= temp;
carry_out <= carry(N-1);
end arch1;
