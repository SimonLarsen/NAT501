entity full_adder is
	port(	a : in bit;
			b : in bit;
			c_in : in bit;
			s : out bit;
			c_out : out bit	);
end entity full_adder;

architecture struct of full_adder is
begin
	s <= (a xor b) xor c_in;
	c_out <= (a and b) or ((a xor b) and c_in);
end architecture struct;