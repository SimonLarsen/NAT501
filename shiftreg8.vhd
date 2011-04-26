entity shiftreg8 is
	port(	clk : in bit;
			clr : in bit;
			input : in bit;
			q : out bit_vector(7 downto 0)
		);
end entity shiftreg8;

architecture struct of shiftreg8 is
	signal qs : bit_vector(7 downto 0);
begin
	process(clk,clr)
	begin
		if clr = '1' then
			qs <= "00000000";
		elsif clk'event and clk = '1' then
			qs(7) <= input;
			qs(6 downto 0) <= qs(7 downto 1);
		end if;
	end process;
	q <= qs;
end architecture struct;