--------------------------------------------------------------------------------
-- Create Date:   18:24:39 12/29/2025  
-- Module Name:   Z:/Ise_Projects/second_project/ticket_system_TB.vhd
-- Project Name:  second_project 
-- VHDL Test Bench Created by ISE for module: ticket_system
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ticket_system_TB IS
END ticket_system_TB;
 
ARCHITECTURE behavior OF ticket_system_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ticket_system
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         req1 : IN  std_logic;
         req2 : IN  std_logic;
         req3 : IN  std_logic;
         ticket_num : OUT  std_logic_vector(3 downto 0);
         current_section : OUT  std_logic_vector(1 downto 0);
         new_ticket : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal req1 : std_logic := '0';
   signal req2 : std_logic := '0';
   signal req3 : std_logic := '0';

 	--Outputs
   signal ticket_num : std_logic_vector(3 downto 0);
   signal current_section : std_logic_vector(1 downto 0):= "00";
   signal new_ticket : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ticket_system PORT MAP (
          clk => clk,
          rst => rst,
          req1 => req1,
          req2 => req2,
          req3 => req3,
          ticket_num => ticket_num,
          current_section => current_section,
          new_ticket => new_ticket
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   
   stim_proc: process
   begin		
      
      rst <= '1';

      wait for 20 ns;

      rst <= '0';

      wait for 20 ns;

      req1 <= '1';
      wait for 10 ns;
      req1 <= '0';

      wait for 20 ns;

      req2 <= '1';
      wait for 10 ns;
      req2 <= '0';

      wait for 20 ns;

      rst <= '1';
      wait for 20 ns;
      rst <= '0';

      wait for 20 ns;

   
      req3 <= '1';
      wait for 10 ns;
      req3 <= '0';

      wait for 20 ns;

      req1 <= '1';
      req3 <= '1';
      wait for 10 ns;
      req1 <= '0';
      req3 <= '0';

      wait for 20 ns;

       
      for i in 1 to 16 loop
         req2 <= '1';
         wait for 10 ns;
         req2 <= '0';
         wait for 20 ns;
      end loop;

      rst <= '1';

      wait;
   end process;

END;
