entity mp4 is
	port(	s : in bit_vector(1 downto 0);
			input : in bit;
			clk : in bit;
			q : out bit;
			c0,c1,c2,c3 : out bit
		);
end mp4;

architecture struct of mp4 is
begin
	process(clk)
	begin
		case s is
			when "00" =>
				c0 <= clk;
				c1 <= '0';
				c2 <= '0';
				c3 <= '0';
			when "01" =>
				c0 <= '0';
				c1 <= clk;
				c2 <= '0';
				c3 <= '0';
			when "10" =>
				c0 <= '0';
				c1 <= '0';
				c2 <= clk;
				c3 <= '0';
			when "11" =>
				c0 <= '0';
				c1 <= '0';
				c2 <= '0';
				c3 <= clk;			
		end case;
	end process;
	q <= input;
end architecture struct;
