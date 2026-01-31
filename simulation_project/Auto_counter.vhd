library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Auto_counter is
	port(req1, req2, req3, clk, rst: in std_logic;
	ticket_num: out std_logic_vector(3 downto 0);
	current_section: out std_logic_vector(1 downto 0);
	new_ticket: out std_logic);
	
end Auto_counter;	

Architecture Behavioral of Auto_counter is
	type state_t is (idle, s1, s2, s3);
	signal state: state_t;	
	signal counter: unsigned(3 downto 0);	

begin								  
	process(clk, rst)
	begin		 
		if rst = '1' then
			state <= idle;
			ticket_num <= "0000"; 
			counter <= "0000";
			current_section <= "00";
			new_ticket <= '0';

		elsif rising_edge(clk) then	 
			new_ticket <= '0';
			
			case state is
				when idle => 			    
				current_section <= "00";  
				if req1 = '1' then 
					state <= s1;
				elsif req2 = '1' then
					state <= s2;
				elsif req3 = '1' then	
					state <= s3;     
				else
					state <= idle;
				end if;	
				
				when s1 => 
					counter <= counter + 1;
					current_section <= "01";
					new_ticket <= '1';		
					ticket_num <= std_logic_vector(counter +1);
					state <= idle;
				when s2 =>			  
					counter <= counter + 1;                    
					current_section <= "10";                   
					new_ticket <= '1';		                   
					ticket_num <= std_logic_vector(counter +1);
					state <= idle;                             
				when s3 =>	
					counter <= counter + 1;                    
					current_section <= "11";                   
					new_ticket <= '1';		                   
					ticket_num <= std_logic_vector(counter +1);
					state <= idle;                             
				
				when others => state <= idle;
			end case;	
		end if;	
	end process;
	
	
end Architecture;