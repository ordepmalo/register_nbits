-------------------------------------------------------------------------------
-- Title         : Register (Testbench)
-- Project       : 
-------------------------------------------------------------------------------
-- File          : register_n_tb.vhd
-- Author        : Pedro Messias Jose da Cunha Bastos
-- Company       : 
-- Created       : 2018-09-07
-- Last update   : 2018-09-07
-- Target Device : 
-- Standard      : VHDL'93/02
-------------------------------------------------------------------------------
-- Description   : 
-------------------------------------------------------------------------------
-- Copyright (c) 2018
-------------------------------------------------------------------------------
-- Revisions     :
-- Date        Version  Author  Description
-- 2018-09-07  1.0      Ordep   Created
-------------------------------------------------------------------------------

-- Bibliotecas e clásulas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------
entity testbench is
end entity testbench;
-------------------------------------

architecture stimulus of testbench is
	
	-- Declaracao de constantes
	constant N_INPUTS : natural := 16;
    -- Decaclaração do componente
    component register_n is
        port(
			clk_enable_i : in std_logic;
			sysclk 		 : in std_logic;
			reset_n		 : in std_logic;
			data_i		 : in std_logic_vector(N_INPUTS-1 downto 0);
			data_o		 : out std_logic_vector(N_INPUTS-1 downto 0)	
        );
    end component register_n;

    -- declaração de sinais
    signal clk_enable_i : std_logic := '0';
	signal sysclk 		: std_logic := '0';
	signal reset_n		: std_logic := '0';
	signal data_i		: std_logic_vector(N_INPUTS-1 downto 0);
	signal data_o		: std_logic_vector(N_INPUTS-1 downto 0);
    
begin  -- inicio do corpo da arquitetura

    -- Instância de divisor_clock com nome dut, pode haver 
    -- quantas mais do que uma
    dut: register_n 
    	generic map (
    		N_INPUTS => N_INPUTS)
    	port map (
    		clk_enable_i => clk_enable_i,
    		sysclk => sysclk,
    		reset_n => reset_n,
        	data_i    => data_i,
        	data_o  => data_o
	   );
	-- clock generation
  	sysclk <= not sysclk after 5 ns;
  	
  	-- reset generation
  	reset_proc: process
 	begin
    	reset_n <= '0';
    	wait for 20 ns; 
    	reset_n <= '1';
    	wait for 50 ns;
    	reset_n <= '0';
    	wait for 10 ns;
    	reset_n <= '1';
    	wait;
  	end process reset_proc;
  	
    -- Stimulus generation
  	stimulus_proc : process
  	begin
    	-- Add stimulus here
		data_i <= "0000000000000001";
		clk_enable_i <= '0';
		wait for 10 ns;
		clk_enable_i <= '1';
		wait for 20 ns;
		clk_enable_i <= '0';
		data_i <= "0000000000000011";
		wait for 20 ns;
		clk_enable_i <= '1';
		wait for 10 ns;
		
    	wait;
  	end process stimulus_proc;

END ARCHITECTURE stimulus;