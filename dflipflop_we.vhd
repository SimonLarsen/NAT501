entity dflipflop_we is
	port(	clk : in bit;
			we  : in bit;
			D   : in bit;
			q   : out bit );
end entity dflipflop_we;

architecture struct of dflipflop_we is
begin
	process(clk)
	begin
		if(clk'event and clk = '1' and we = '1') then
			q <= D;
		end if;
	end process;
end architecture struct;