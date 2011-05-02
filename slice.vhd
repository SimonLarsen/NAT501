entity slice is
	port(	ym_in, zm_in, m_in, pop, clk, top_b_in, top_q_in, top_s_in,
			bot_s_in, bot_q_in, bot_b_in, mp4_clk0, mp4_clk1, mp4_clk2 : in bit;
			ym_out, zm_out, m_out, top_b_out, top_q_out, top_s_out,
			bot_s_out, bot_q_out, bot_b_out : out bit
		);
end slice;

architecture struct of slice is
	component shiftreg2
		port(	clk, clr, input : in bit;
			q0,q1 : out bit
		);
	end component shiftreg2;
	
	component MMCell
		port(	s_in : in bit;
				s_out : out bit;
				m0,m1 : in bit;
				a0,a1 : in bit;
				clk : in bit;
				q_in, b_in : in bit;
				q_out, b_out : out bit
			);
	end component MMCell;
	
	component full_adder
		port(	a : in bit;
			b : in bit;
			c_in : in bit;
			s : out bit;
			c_out : out bit	);
	end component full_adder;

	component dflipflop
		port(	clk : in bit;
			clr : in bit;
			D   : in bit;
			q   : out bit );
	end component dflipflop;
	
	signal y1_ym1, y0_ym0, pop_clk, clk_ym, clk_zm, y0_a0, y1_a1, q0_m0, q1_m1,
			z1_a1, z0_a0, z1_zm1, z0_zm0, GND : bit;
	
	begin
		ym : shiftreg2 port map (input => ym_in, clr => pop, clk => clk_ym, q1 => y1_ym1, q0 => y0_ym0);
		y1 : dflipflop port map (D => y1_ym1, clr => GND, clk => pop_clk, q => y1_a1);
		y0 : dflipflop port map (D => y0_ym0, clr => GND, clk => pop_clk, q => y0_a0);
		top_mm : MMCell port map (b_in => top_b_in, q_in => top_q_in, clk => clk, a1 => y1_a1, a0 => y0_a0,
				m1 => q1_m1, m0 => q0_m0, s_in => top_s_in, b_out => top_b_out, q_out => top_q_out, s_out => top_s_out);
		bot_mm : MMCell port map (s_in => bot_s_in, m0 => q0_m0, m1 => q1_m1, a0 => z0_a0, a1 => z1_a1,
				clk => clk, q_in => bot_q_in, b_in => bot_b_in, s_out => bot_s_out, q_out => bot_q_out, b_out => bot_b_out);
		modulus : shiftreg2 port map (q0 => q0_m0, q1 => q1_m1, clr => GND, clk => mp4_clk2, input => m_in);
		z1 : dflipflop port map (D => z1_zm1, clr => GND, clk => pop_clk, q => z1_a1);
		z0 : dflipflop port map (D => z0_zm0, clr => GND, clk => pop_clk, q => z0_a0);
		zm : shiftreg2 port map (input => zm_in, clr => pop, clk => clk_zm, q0 => z0_zm0, q1 => z1_zm1);
		
		pop_clk <= pop or clk;
		ym_out <= y0_ym0;
		m_out <= q0_m0;
		zm_out <= z0_zm0;
		clk_ym <= clk or mp4_clk0;
		clk_zm <= clk or mp4_clk1;

		GND <= '0';
end architecture;
