entity MMCell is
	port(	s_in : in bit;
			s_out : out bit;
			m0,m1 : in bit;
			a0,a1 : in bit;
			clk : in bit;
			q_in, b_in : in bit;
			q_out, b_out : out bit
		);
end entity MMCell;

architecture struct of MMCell is
component full_adder
	port(	a : in bit;
			b : in bit;
			c_in : in bit;
			s : out bit;
			c_out : out bit );
end component full_adder;

component dflipflop
	port(	clk, D : in bit;
			q : out bit );
end component dflipflop;

signal abr_ab, a0_ab, a1_ab, ab_ams, ab_ms, ams_sr, ms_abr, m1_mq, 
		m0_mq, mqr_mq, mq_ams, mq_ms, ams_mqr, msr_ms, ms_msr, b_a1, q_m1 : bit;

begin
	b_reg : dflipflop port map ( D => b_in, clk => clk, q => b_a1 );
	b_out <= b_a1; 

	a0_ab <= a0 and b_in;
	a1_ab <= a1 and b_a1;

	q_reg : dflipflop port map ( D => q_in, clk => clk, q => q_m1 );
	q_out <= q_m1;

	m0_mq <= m0 and q_in;
	m1_mq <= m1 and q_m1;

	ab_reg : dflipflop port map ( D => ms_abr, clk => clk, q => abr_ab );
	ab_fa : full_adder port map ( a => abr_ab, b => a0_ab, c_in => a1_ab, s => ab_ams, c_out => ab_ms );

	mq_reg : dflipflop port map ( D => ams_mqr, clk => clk, q => mqr_mq );
	mq_fa : full_adder port map ( a => m1_mq, b => m0_mq, c_in => mqr_mq, s => mq_ams, c_out => mq_ms );

	ams_fa : full_adder port map ( a => ab_ams, b => s_in, c_in => mq_ams, s => ams_sr, c_out => ams_mqr );

	ms_reg : dflipflop port map ( D => ms_msr, clk => clk, q => msr_ms );
	ms_fa : full_adder port map ( a => ab_ms, b => mq_ms, c_in => msr_ms, s => ms_abr, c_out => ms_msr );

	s_reg : dflipflop port map ( D => ams_sr, clk => clk, q => s_out );
end architecture struct;
