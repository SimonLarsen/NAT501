entity shiftreg17 is
	port(	clk : in bit;
			clr : in bit;
			input : in bit;
			q : out bit
		);
end entity shiftreg17;

architecture struct of shiftreg17 is
	signal qs : bit_vector(16 downto 0) := "11000000000000000";
begin
	process(clk,clr)
	begin
		if clr = '1' then
			qs <= "00000000000000000";
		elsif clk'event and clk = '1' then
			
			qs(15 downto 0) <= qs(16 downto 1);
			qs(16) <= input;
		end if;
	end process;
	q <= qs(0);
end architecture struct;
