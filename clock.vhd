library ieee;
use ieee.numeric_std.all;

entity clock is
	port(	clk : in bit;
			clkout : inout bit );
end entity clock;

architecture struct of clock is
	signal count : integer range 0 to 500000;
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if count = 500000 then
				count <= 0;
				clkout <= not clkout;
			else
				count <= count + 1;
			end if;
		end if;
	end process;
end architecture struct;