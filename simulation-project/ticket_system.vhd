----------------------------------------------------------------------------------
-- Create Date:    04:15:05 12/29/2025 
-- Design Name: 
-- Module Name:    ticket_system - Behavioral 
-- Project Name:   second_project 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ticket_system is
    port(
        clk             : in std_logic;
        rst             : in std_logic;
        req1            : in std_logic;
        req2            : in std_logic;
        req3            : in std_logic;

        ticket_num      : out std_logic_vector(3 downto 0);
        current_section : out std_logic_vector(1 downto 0);
        new_ticket      : out std_logic
    );
end ticket_system;

architecture Behavioral of ticket_system is
    
    type   system_states is (WAITING, TICKETING);
    signal state : system_states;


    signal counter      : std_logic_vector(3 downto 0) := "0000";
    signal section_temp : std_logic_vector(1 downto 0) := "00";


begin

    process(clk, rst)
    begin

        if rst = '1' then
            ticket_num      <= "0000";         
			current_section <= "00";
            new_ticket      <= '0';
            state           <= WAITING;

        elsif rising_edge(clk) then   
            new_ticket      <= '0';
            current_section <= section_temp;
            ticket_num      <= std_logic_vector(counter);

            case state is
            
                when WAITING =>

                    -- priority: req1, req2, req3
                    if req1 = '1' then
                        section_temp <= "01";
                        state <= TICKETING;

                    elsif req2 = '1' then
                        section_temp <= "10";
                        state <= TICKETING;

                    elsif req3 = '1' then
                        section_temp <= "11";
                        state <= TICKETING;

                    else
                        section_temp <= section_temp;

                    end if; 

				 
                when TICKETING =>
                    new_ticket <= '1';

					if counter = "1111" then
                        counter <= "0000";
					else      
                        counter <= std_logic_vector(unsigned(counter) + 1);
                    end if;

                    current_section <= section_temp;
                    state <= WAITING;

                when others =>
                    state      <= WAITING;
                    new_ticket <= '0';

            end case;   
        end if; 
    end process; 

end Behavioral;