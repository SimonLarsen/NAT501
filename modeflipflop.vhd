library ieee;
use ieee.numeric_std.all;

entity modeflipflop is
	port( clk : in bit;
			q, pop : out bit
		);
end entity modeflipflop;

architecture struct of modeflipflop is
	signal count : integer range 0 to 32 := 0;
begin
	process(clk)
	begin
		if(clk'event and clk='1') then
			if(count < 8) then
				count <= count+1;
				q <= '0';
				pop <= '0';
			elsif(count < 16) then
				count <= count+1;
				q <= '1';
				pop <= '0';
			elsif(count < 17) then
				count <= count+1;
				q <= '0';
				pop <= '1';
			else
				count <= 0;
				q <= '0';
				pop <= '0';
			end if;
		end if;
	end process;
end architecture struct;