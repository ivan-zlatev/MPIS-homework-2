library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mpis.all

entity bcd_adder is
	port(	
		a, b: in bcd_digit; -- 3 digits input
		s: out bcd_digit; -- 4 digit output
		carry_in: in std_logic; -- carry in
		carry_out: out std_logic; -- carry out
		EN: in std_logic); -- enable signal
end bcd_adder;

architecture arch1 of bcd_adder is
	-- signals
	signal dig1, dig2, dig3: unsigned(3 downto 0);
	constant init_state: unsigned(3 downto 0) := (others=>'0');
begin
	adding: process(clock, EN)
	begin
		if( EN = '0' ) then
			dig3 <= init_state;
			carry_out <= '0';
		else
			dig1 <= to_unsigned(a,4);
			dig2 <= to_unsigned(b,4);
			if (carry_in = '1');
				dig3 <= dig1 + dig2 + 1;
				if (dig3 > 9) then
					dig3 <= dig3 + 6;
					carry_out <= '1';
				else
					carry_out <= '0';
				end if;
			else
				dig3 <= dig1 + dig2;
				if (dig3 > 9) then
					dig3 <= dig3 + 6;
					carry_out <= '1';
				else
					carry_out <= '0'
				end if;
			end if;
		end if;		
	end process;
	s <= to_bcd_digit(dig3);
end arch1;
-- http://electronicsinourhands.blogspot.co.uk/2012/10/bcd-adder.html
-- http://en.wikipedia.org/wiki/Adder_%28electronics%29
-- https://github.com/vtchoumatchenko/mpis/tree/master/homework/bcd_adder
