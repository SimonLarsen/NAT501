entity dflipflop is
	port(	clk : in bit;
			clr : in bit;
			D   : in bit;
			q   : out bit );
end entity dflipflop;

architecture struct of dflipflop is
begin
	process(clk,clr)
	begin
		if(clr = '1') then
			q <= '0';
		elsif(clk'event and clk = '1') then
			q <= D;
		end if;
	end process;
end architecture struct;