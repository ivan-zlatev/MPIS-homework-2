library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package mpis is
	subtype bcd_digit is natural range 0 to 9;
	type bcd_number is array( natural range<>) of bcd_digit;

	function to_bcd_digit( var: unsigned(3 downto 0)) return bcd_digit;
	function seven_segment_decoder( hex: unsigned(3 downto 0)) return std_logic_vector;
end mpis

package body mpis is
	function to_bcd_digit( var: unsigned(3 downto 0)) return bcd_digit is
		variable ret: bcd_digit;
	begin
		case (var) is
			when "0000" => ret := 0;
			when "0001" => ret := 1;
			when "0010" => ret := 2;
			when "0011" => ret := 3;
			when "0100" => ret := 4;
			when "0101" => ret := 5;
			when "0110" => ret := 6;
			when "0111" => ret := 7;
			when "1000" => ret := 8;
			when "1001" => ret := 9;
		end case;
		return ret;
	end to_bcd_digit;

	eunction seven_segment_decoder( hex: unsigned(3 downto 0)) return std_logic_vector is
		variable leds: std_logic_vector(6 downto 0);
	begin
		-- segment encoding
		--      0
		--     --- 
		--  5 |   | 1
		--     ---   <- 6
		--  4 |   | 2
		--     ---
		--      3
		case (hex) is
			when "0000" => leds := "1000000"; --0
			when "0001" => leds := "1111001"; --1
			when "0010" => leds := "0100100"; --2
			when "0011" => leds := "0110000"; --3
			when "0100" => leds := "0011001"; --4
			when "0101" => leds := "0010010"; --5
			when "0110" => leds := "0000010"; --6
			when "0111" => leds := "1111000"; --7
			when "1000" => leds := "0000000"; --8
			when "1001" => leds := "0010000"; --9
			when "1010" => leds := "0001000"; -- A
			when "1011" => leds := "0000011"; -- b
			when "1100" => leds := "1000110"; -- C
			when "1101" => leds := "0100001"; -- d
			when "1110" => leds := "0000110"; -- E
			when "1111" => leds := "0001110"; -- F  
			when others => leds := "1111111"; -- nothing
		end case;
		return leds;
	end seven_segment_decoder;
end mpis;
