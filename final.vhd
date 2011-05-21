entity final is
	port(	knap0, knap1, knap2, knap3, switch : in bit;
			selectors : in bit_vector(1 downto 0);
			f_out_led : out bit;
			zm0, zm1, zm2, zm3,	ym0, ym1, ym2, ym3,
			m0, m1, m2, m3,	y0, y1, y2, y3 : out bit_vector(1 downto 0);
			e_led_out : out bit_vector(7 downto 0)
		);
end final;

architecture struct of final is
	component mp4
	port(	s : in bit_vector(1 downto 0);
			input, clk : in bit;
			q : out bit;
			c0,c1,c2,c3 : out bit
		);
	end component mp4;

	component shiftreg8
	port(	clk, clr, input : in bit;
			q : out bit
		);
	end component shiftreg8;

	component shiftreg9
	port(	clk,clr, input : in bit;
			q: out bit;
			q_led: out bit_vector(7 downto 0)
		);
	end component shiftreg9;

	component shiftreg17
	port(	clk, clr, input : in bit;
			q : out bit
		);
	end component shiftreg17;

	component dflipflop
	port(	clk, D : in bit;
			q   : out bit
		);
	end component;

	component qswitch
	port(	s_in, f : in bit;
			q, s_out : out bit
		);
	end component qswitch;

	component slice
	port(	ym_in, zm_in, m_in, pop, clk, top_b_in, top_q_in, top_s_in,
			bot_s_in, bot_q_in, bot_b_in, mp4_clk0, mp4_clk1, mp4_clk2, e_in : in bit;
			ym_out, zm_out, m_out, top_b_out, top_q_out, top_s_out,
			bot_s_out, bot_q_out, bot_b_out : out bit;
			zm_led, ym_led, m_led, y_led : out bit_vector(1 downto 0)
		);
	end component slice;

	signal GND_in, GND_out, not_knap3, not_knap2, knap2_or_3,
	mp4_q, mp4_c0, mp4_c1, mp4_c2, mp4_c3,
	mp4_or_s_y, mp4_or_s_z,	e_clk,
	f_ff_q, final_clk, final_pop,
	not_switch_and_knap1, load_reg_q,
	load_ff_q, f_reg_q, not_f_reg_q, e_reg_q, e_in,
	s_y, s_z, q_y, q_z,	s0_top_s, s0_bot_s,	s0_zm,
	s0_top_b, s0_bot_b, s0_top_q, s0_bot_q,
	s1_top_s, s1_ym, s1_m, s1_top_q, s1_zm, s1_bot_s, 
	s1_top_b, s1_bot_q, s1_bot_b, s2_ym, s2_m, s2_top_s,
	s2_zm, s3_zm, s2_bot_s, s2_bot_q,
	s2_top_b, s2_top_q, s2_bot_b, 
	s3_ym, s3_m, s3_top_s, s3_bot_s, s3_bot_q : bit;
begin
	mp4_inst : mp4 port map (input => not_knap3, clk => knap2_or_3, s => selectors, q => mp4_q,
		c0 => mp4_c0, c1 => mp4_c1, c2 => mp4_c2, c3 => mp4_c3);

	e_reg : shiftreg9 port map (clk => e_clk, clr => GND_in, input => mp4_q, q => e_reg_q, q_led => e_led_out);

	load_reg : shiftreg17 port map (clk => not_switch_and_knap1, input => load_ff_q, clr => GND_in, q => load_reg_q);

	load_ff : dflipflop port map (clk => not_switch_and_knap1, D => load_reg_q, q => load_ff_q);

	f_reg : shiftreg8 port map (clk => final_clk, q => f_reg_q, clr => GND_in, input => not_f_reg_q);

	f_ff : dflipflop port map (clk => final_clk, D => f_reg_q, q => f_ff_q);

	y_qswitch : qswitch port map (f => f_ff_q, s_out => s_y, q => q_y, s_in => s0_top_s);

	z_qswitch : qswitch port map (f => f_ff_q, s_out => s_z, q => q_z, s_in => s0_bot_s);

	s0 : slice port map (zm_out => s0_zm, top_b_in => s0_zm, bot_b_in => s0_zm, top_q_in => q_y, top_s_out => s0_top_s,
		bot_s_out => s0_bot_s, bot_q_in => q_z, ym_out => GND_out, m_out => GND_out, e_in => e_in,
		mp4_clk0 => mp4_c0, mp4_clk1 => mp4_c1, mp4_clk2 => mp4_c2, pop => final_pop, clk => final_clk,
		y_led => y0, m_led => m0, ym_led => ym0, zm_led => zm0, ym_in => s1_ym, m_in => s1_m, 
		top_q_out => s0_top_q, top_s_in => s1_top_s, zm_in => s1_zm, top_b_out => s0_top_b, bot_b_out => s0_bot_b,
		bot_s_in => s1_bot_s, bot_q_out => s0_bot_q);

	s1 : slice port map (ym_out => s1_ym, m_out => s1_m, top_q_in => s0_top_q, top_s_out => s1_top_s, zm_out => s1_zm,
		top_b_in => s0_top_b, bot_b_in => s0_bot_b, bot_s_out => s1_bot_s, bot_q_in => s0_bot_q, e_in => e_in, 
		mp4_clk0 => mp4_c0, mp4_clk1 => mp4_c1, mp4_clk2 => mp4_c2, pop => final_pop, clk => final_clk,
		y_led => y1, m_led => m1, ym_led => ym1, zm_led => zm1, ym_in => s2_ym, m_in => s2_m,
		top_q_out => s1_top_q, top_s_in => s2_top_s, zm_in => s2_zm, top_b_out => s1_top_b, bot_b_out => s1_bot_b,
		bot_s_in => s2_bot_s, bot_q_out => s1_bot_q);

	s2 : slice port map (ym_out => s2_ym, m_out => s2_m, top_q_in => s1_top_q, top_s_out => s2_top_s, zm_out => s2_zm, top_b_in => s1_top_b,
		bot_b_in => s1_bot_b, bot_s_out => s2_bot_s, bot_q_in => s1_bot_q, e_in => e_in,
		mp4_clk0 => mp4_c0, mp4_clk1 => mp4_c1, mp4_clk2 => mp4_c2, pop => final_pop, clk => final_clk,
		y_led => y2, m_led => m2, ym_led => ym2, zm_led => zm2, ym_in => s3_ym, m_in => s3_m, top_q_out => s2_top_q,
		top_s_in => s3_top_s, zm_in => s3_zm, top_b_out => s2_top_b, bot_b_out => s2_bot_b,
		bot_s_in => s3_bot_s, bot_q_out => s2_bot_q);

	s3 : slice port map (ym_out => s3_ym, m_out => s3_m, top_q_in => s2_top_q, top_s_out => s3_top_s, zm_out => s3_zm, top_b_in => s2_top_b,
		bot_b_in => s2_bot_b, bot_s_out => s3_bot_s, bot_q_in => s2_bot_q, e_in => e_in,
		mp4_clk0 => mp4_c0, mp4_clk1 => mp4_c1, mp4_clk2 => mp4_c2, pop => final_pop, clk => final_clk,
		y_led => y3, m_led => m3, ym_led => ym3, zm_led => zm3, ym_in => mp4_or_s_y, m_in => mp4_q, 
		top_q_out => GND_out, top_s_in => GND_in, zm_in => mp4_or_s_z, top_b_out => GND_out, bot_b_out => GND_out,
		bot_s_in => GND_in, bot_q_out => GND_out);

	not_knap3 <= not knap3;
	not_knap2 <= not knap2;
	knap2_or_3 <= not_knap2 or not_knap3;
	e_clk <= mp4_c3 or f_ff_q;
	not_switch_and_knap1 <= (not switch) and knap1;
	final_clk <= (not load_ff_q) and not_switch_and_knap1;	
	final_pop <= (not knap0) or ((not load_reg_q) and (not switch)); -- MAASKE BUGGY?!
	not_f_reg_q <= not f_reg_q;
	f_out_led <= f_ff_q;
	e_in <= e_reg_q or switch;
	mp4_or_s_y <= mp4_q or s_y;
	mp4_or_s_z <= mp4_q or s_z;

	GND_in <= '0';
	GND_out <= '0';

end architecture struct;
