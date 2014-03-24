library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mpis.all;
 
entity bcd_adder_test is
end bcd_adder_test;
 
architecture test of bcd_adder_test is
    constant N: positive := 3;

    signal a,b : bcd_number(N-1 downto 0);
    signal s : bcd_number(N downto 0);
	constant clock_period : time := 1 ns;
	signal clock : std_logic := '0';
	signal clock_run : boolean := true;
	 
	 signal carry_in, carry_out, EN : std_logic;
      
    procedure integer_to_bcd(int: in integer; signal bcd: out bcd_number) is
        variable limit: integer;
    begin
        -- parameters check
        assert 10**bcd'length-1 >= int report "The 'bcd' parameter is not long enough for 'int'=" & integer'image(int); 
        assert bcd'right = 0 report "The 'bcd' range must be in the format 'N downto 0'";
        
        for i in bcd'range loop
            bcd(i) <= (int mod 10**(i+1)) / 10**i;
        end loop;
    end;
    
    procedure bcd_to_integer(signal bcd: in bcd_number; int: out integer) is
        variable tmp: integer;
    begin
        -- parameters check    
        assert bcd'right = 0 report "The 'bcd' range must be in the format 'N downto 0'";
        
        tmp := 0;
        for i in bcd'right to bcd'left loop
            tmp := tmp + 10**i * bcd(i);
        end loop;
        int := tmp;
    end;    
    
begin
    uut: entity work.bcd_adder_top
    port map(
		clock => clock,
		a => a,
		b => b,
		s => s,
		carry_in => carry_in,
		carry_out => carry_out,
		EN => EN);
		
	clock_process :process
		begin
			if clock_run then
				clock <= '0';
				wait for clock_period/2;
				clock <= '1';
				wait for clock_period/2;
			else
				wait;
			end if;
		end process;
		
    stim_proc: process
        variable expected, actual: integer;     
    begin
		carry_in <= '0';
		EN <= '1';
		wait for 10 ns;
        for i1 in 0 to 10**N-1 loop
            for i0 in 0 to 10**N-1 loop
                integer_to_bcd(i0, a);
                integer_to_bcd(i1, b);
                wait for 10 ns;                
                expected := i0 + i1;
                bcd_to_integer(s, actual);
                assert actual = expected report "expected " & integer'image(expected) & "   actual " & integer'image(actual);   
            end loop;        
        end loop;
		  clock_run <= false;
        wait;
    end process;
end;