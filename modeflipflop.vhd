library ieee;
use ieee.numeric_std.all;

entity modeflipflop is
	port( clk : in bit;
			q : out bit
		);
end entity modeflipflop;

architecture struct of modeflipflop is
	signal count : integer range 0 to 9;
begin
	process(clk)
	begin
		if(clk'event and clk='1') then
			if(count > 0) then
				count <= count-1;
				q <= '0';
			else
				q <= '1';
			end if;
		end if;
	end process;
end architecture struct;