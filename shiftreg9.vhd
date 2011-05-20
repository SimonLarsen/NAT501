entity shiftreg9 is
	port(	clk : in bit;
			clr : in bit;
			input : in bit;
			q: out bit;
			q_led: out bit_vector(7 downto 0)
		);
end entity shiftreg9;

architecture struct of shiftreg9 is
	signal qs : bit_vector(8 downto 0) := "000000000";
begin
	process(clk,clr)
	begin
		if clr = '1' then
			qs <= "000000000";
		elsif clk'event and clk = '1' then
			qs(8) <= input;
			qs(7 downto 0) <= qs(8 downto 1);
		end if;
	end process;
	q <= qs(0);
	q_led(7 downto 0) <= qs(8 downto 1);
end architecture struct;