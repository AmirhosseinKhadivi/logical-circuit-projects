library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity auto_counter_tb is
end auto_counter_tb;

architecture TB_ARCHITECTURE of auto_counter_tb is
	-- Component declaration of the tested unit
	component auto_counter
	port(
		req1 : in STD_LOGIC;
		req2 : in STD_LOGIC;
		req3 : in STD_LOGIC;
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		ticket_num : out STD_LOGIC_VECTOR(3 downto 0);
		current_section : out STD_LOGIC_VECTOR(1 downto 0);
		new_ticket : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal req1 : STD_LOGIC;
	signal req2 : STD_LOGIC;
	signal req3 : STD_LOGIC;
	signal clk : STD_LOGIC;
	signal rst : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ticket_num : STD_LOGIC_VECTOR(3 downto 0);
	signal current_section : STD_LOGIC_VECTOR(1 downto 0);
	signal new_ticket : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : auto_counter
		port map (
			req1 => req1,
			req2 => req2,
			req3 => req3,
			clk => clk,
			rst => rst,
			ticket_num => ticket_num,
			current_section => current_section,
			new_ticket => new_ticket
		);

	-- Add your stimulus here ...
	stim_proc: process
	begin
		req1 <= '0';
		req2 <= '0';
		req3 <= '0';
		clk  <= '0';
		rst  <= '1';
		wait for 50 ns;
		
		clk <= '1';
		wait for 50 ns;
		clk <= '0';
		wait for 50 ns;
		rst <= '0';
		
		wait for 50 ns;
		req1 <= '1';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		req1 <= '0';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;	 
		
		wait for 50 ns;
		req3 <= '1';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		req3 <= '0';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		
		req1 <= '1';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		req1 <= '0';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		
		wait for 50 ns;
		req1 <= '1';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		req1 <= '0';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		
		wait for 50 ns;
		req2 <= '1';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		req2 <= '0';
		clk  <= '1';
		wait for 50 ns;
		clk  <= '0';
		wait for 50 ns;
		
		
		wait;
		
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_auto_counter of auto_counter_tb is
	for TB_ARCHITECTURE
		for UUT : auto_counter
			use entity work.auto_counter(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_auto_counter;