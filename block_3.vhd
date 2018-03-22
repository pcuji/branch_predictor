--block_3
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity block_3 is 
	port(
		clk ,clear : in std_logic;
		sig_predictor : out std_logic_vector( 5 downto 0);
		sig_d_to_shift_reg : in std_logic;
		
		en_up_d_0001, en_up_d_0010 : in std_logic;
		en_up_d_0011, en_up_d_0100 : in std_logic;
		en_up_d_0101, en_up_d_0110 : in std_logic;
		en_up_d_0111, en_up_d_1000 : in std_logic;
		en_up_d_1001, en_up_d_1010 : in std_logic;
		en_up_d_1011, en_up_d_1100 : in std_logic;
		en_up_d_1101, en_up_d_1110 : in std_logic;
		en_up_d_1111, en_up_d_0000 : in std_logic;
		

	);
end block_3;
architecture struc of block_3 is

	signal temp_sig_gbh_pre_update : std_logic_vector (5 downto 0);
	signal temp_q :std_logic_vector(3 downto 0);
--conections between mux and counters 16 signals	
	signal master_sig_mux_0: std_logic_vector(5 downto 0);
	signal master_sig_mux_1: std_logic_vector(5 downto 0);
	signal master_sig_mux_2: std_logic_vector(5 downto 0);
	signal master_sig_mux_3: std_logic_vector(5 downto 0);
	signal master_sig_mux_4: std_logic_vector(5 downto 0);
	signal master_sig_mux_5: std_logic_vector(5 downto 0);
	signal master_sig_mux_6: std_logic_vector(5 downto 0);
	signal master_sig_mux_7: std_logic_vector(5 downto 0);
	signal master_sig_mux_8: std_logic_vector(5 downto 0);
	signal master_sig_mux_9: std_logic_vector(5 downto 0);
	
begin 
	my_counter_0000 : entity work.ud_counter_3(struc)
		port map (clk 				=>clk,
				clear 				=>clear,
				up_down				=>	en_up_d_0000,	
				counter_sig_predict	=> master_sig_mux_0,
				enable				=> temp_en_counter0,
				counter_gbh			=>	"0000"
					);
	my_counter_0001 : entity work.ud_counter_3(struc)
		port map (clk 				=>clk,
				clear 				=>clear,
				up_down				=>en_up_d_0001,	
				counter_sig_predict	=> master_sig_mux_1,
				enable				=> temp_en_counter1,
				counter_gbh			=>	"0001"
					);
	my_counter_0010 : entity work.ud_counter_3(struc)
		port map (clk 				=>clk,
				clear 				=>clear,
				up_down				=>en_up_d_0010,	
				counter_sig_predict	=> master_sig_mux_2,
				enable				=> temp_en_counter2,
				counter_gbh			=>	"0010"
					);
	
	my_counter_1111: entity work.ud_counter_3(struc)
		port map (clk 				=>clk,
				clear 				=>clear,
				up_down				=>	en_up_d_1111,	
				counter_sig_predict	=> master_sig_mux_F,
				enable				=> temp_en_counterF,
				counter_gbh			=>	"1111"
					);
--mux_16 component
	my_mux_16 :entity work.mux_16(struc)
		port map (q_gbh				=> temp_q,
				sig_gbh_pre_update	=> temp_sig_gbh_pre_update,
				gbh_0000 			=>	master_sig_mux_0,
				gbh_0001 			=> 	master_sig_mux_1,
				gbh_0010 			=> 	master_sig_mux_2,
				gbh_0011 			=>	master_sig_mux_3,
				gbh_0100 			=>	master_sig_mux_4,
				gbh_0101 			=>	master_sig_mux_5,
				gbh_0110 			=>	master_sig_mux_6,
				gbh_0111 			=>	master_sig_mux_7,
				gbh_1000 			=>	master_sig_mux_8,
				gbh_1001 			=>	master_sig_mux_9,
				gbh_1010 			=>	master_sig_mux_A,
				gbh_1011 			=>	master_sig_mux_B,
				gbh_1100 			=>	master_sig_mux_C,
				gbh_1101 			=>	master_sig_mux_D,
				gbh_1110 			=>	master_sig_mux_E,
				gbh_1111 			=>	master_sig_mux_F
					);
	
--shift resigter
	my_shift_reg : entity work.shift_reg(arch)
		port map (clk				=> clk,
				reset 				=> clear,
				d					=>	sig_d_to_shift_reg,
				q					=>	temp_q
					);
	
	sig_predictor <= temp_sig_gbh_pre_update;
end struc;