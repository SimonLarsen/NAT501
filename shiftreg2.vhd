entity shiftreg2 is
	port(	clk : in bit;
			clr : in bit;
			input : in bit;
			q : out bit_vector(1 downto 0)
		);
end entity shiftreg2;

architecture struct of shiftreg2 is
	signal qs : bit_vector(1 downto 0);
begin
	process(clk,clr)
	begin
		if clr = '1' then
			qs <= "00";
		elsif clk'event and clk = '1' then
			qs(1) <= input;
			qs(0) <= qs(1);
		end if;
	end process;
	q <= qs;
end architecture struct;
