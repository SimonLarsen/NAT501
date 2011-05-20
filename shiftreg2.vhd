entity shiftreg2 is
	port(	clk : in bit;
			clr : in bit;
			input : in bit;
			q0,q1 : out bit
		);
end entity shiftreg2;

architecture struct of shiftreg2 is
	signal qs0,qs1 : bit;
begin
	process(clk,clr)
	begin
		if clr = '1' then
			qs0 <= '0';
			qs1 <= '0';
		elsif clk'event and clk = '1' then
			qs1 <= input;
			qs0 <= qs1;
		end if;
	end process;
	q0 <= qs0;
	q1 <= qs1;
end architecture struct;
