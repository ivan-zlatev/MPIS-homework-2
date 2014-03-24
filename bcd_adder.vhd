library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mpis.all;

entity bcd_adder is
	port(
		clock: in std_logic;
		a, b: in bcd_digit; -- 1 digit input
		s: out bcd_digit; -- 1 digit output
		carry_in: in std_logic; -- carry in
		carry_out: out std_logic; -- carry out
		EN: in std_logic); -- enable signal
end bcd_adder;

architecture arch1 of bcd_adder is
	-- signals
	signal dig1, dig2 : unsigned(4 downto 0);
	signal dig3 : bcd_digit;
begin
	adding: process(clock)
	begin
		if( EN = '0' ) then
			carry_out <= '0';
		else
			dig1 <= to_unsigned(a,5);
			dig2 <= to_unsigned(b,5);
			if (carry_in = '1') then
				if ((dig1 + dig2 + 1) > 9) then
					dig3 <= to_bcd_digit(dig1 + dig2 + 1);
					carry_out <= '1';
				else
					dig3 <= to_bcd_digit(dig1 + dig2 + 1);
					carry_out <= '0';
				end if;
			else
				if ((dig1 + dig2) > 9) then
					dig3 <= to_bcd_digit(dig1 + dig2);
					carry_out <= '1';
				else
					dig3 <= to_bcd_digit(dig1 + dig2);
					carry_out <= '0';
				end if;
			end if;
		end if;
	end process;
	s <= dig3;
end arch1;
-- http://electronicsinourhands.blogspot.co.uk/2012/10/bcd-adder.html
-- http://en.wikipedia.org/wiki/Adder_%28electronics%29
-- https://github.com/vtchoumatchenko/mpis/tree/master/homework/bcd_adder
