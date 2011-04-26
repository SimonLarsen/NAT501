entity qswitch is
	port(	s_in : in bit;
			f : in bit;
			q : out bit
			s_out : out bit;
		);
end entity qswitch;

architecture struct of qswitch is
begin
	q <= s_in and (not f);
	s_out <= s_in and f;
end architecture struct;