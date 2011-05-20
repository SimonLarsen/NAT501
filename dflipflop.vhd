entity dflipflop is
	port(	clk : in bit;
			D   : in bit;
			q   : out bit );
end entity dflipflop;

architecture struct of dflipflop is
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			q <= D;
		end if;
	end process;
end architecture struct;