library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity predictor_3_tb is 
end predictor_3_tb;
architecture tb of predictor_3_tb is 
	signal clk, dreset : std_logic;
	signal pre : std_logic_vector( 5 downto 0);
	signal dsig_actual : std_logic_vector(1 downto 0);
	constant clk_period : time := 50 ns;
	signal misses_count : integer :=0;
	signal out_miss : std_logic;
begin 
	my_predictor : entity work.predictor_3(struc)
		port map (my_sig_predic				=>	pre,		--prediction after update
		my_sig_actual						=>	dsig_actual, 
		clk									=>	clk ,
		reset								=>	dreset,
		my_miss								=>	out_miss
					);	
	process 
		begin 
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period /2;
	end process;
	dreset <= '1' , '0' after 25 ns;
	--dreset <= '1' , '0' after clk_period/2;
		
	process 
		
		begin 
	
		wait until rising_edge(clk);
				dsig_actual <= "00";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
		wait until rising_edge(clk);
		dsig_actual <= "00";
		wait until rising_edge(clk);
		dsig_actual <= "00";
		wait until rising_edge(clk);
		dsig_actual <= "00";
		wait until rising_edge(clk);
		dsig_actual <= "00";
		
		
				
				wait until rising_edge(clk);
				dsig_actual <= "11";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
				wait until rising_edge(clk);
				dsig_actual <= "11";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
				wait until rising_edge(clk);
				dsig_actual <= "11";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
				wait until rising_edge(clk);
				dsig_actual <= "10";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
		
		for I in 1 to 999 loop
		-----------------------------------
			 
				wait until rising_edge(clk);
				dsig_actual <= "01";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
				wait until rising_edge(clk);
				dsig_actual <= "11";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
				wait until rising_edge(clk);
				dsig_actual <= "11";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
				wait until rising_edge(clk);
				dsig_actual <= "11";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
				wait until rising_edge(clk);
				dsig_actual <= "10";
				if ( out_miss = '0') then 
					misses_count <= misses_count +1;
				end if;
		end loop;
		misses_count <= misses_count +1;			--miss for the last outer loop
		report "Number of misses: " & integer'image(misses_count);
		assert false
				report "Simulation Complete"
			severity failure;	
	end process;
end tb;