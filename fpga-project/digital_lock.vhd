library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity digital_lock is
    port(
        clk      : in  std_logic;
        btn1     : in  std_logic;
        btn2     : in  std_logic;
        switch   : in  std_logic_vector(3 downto 0);

        sevenSeg : out STD_LOGIC_VECTOR(7 downto 0);
        an       : out STD_LOGIC_VECTOR(3 downto 0);
        led      : out std_logic_vector(7 downto 0)
    );
end digital_lock;


architecture Behavioral of digital_lock is
 
    signal phase : integer range 1 to 4 := 1;

    signal correct_pass : STD_LOGIC := '0';
    signal reachedTo15  : STD_LOGIC := '0';

    signal state            : natural range 0 to 7          := 0;
    signal state_cnt        : natural range 0 to 25_000_000 := 0;

    signal counter         : natural range 0 to 15 := 0;
    signal counter_cnt     : natural range 0 to 25_000_000 := 0;
    
    signal sevenSeg_cnt    : natural range 0 to 50000 := 0;
    signal sevenSeg_select : natural range 0 to 3 := 0;
    signal sevenSeg_temp   : STD_LOGIC_VECTOR(7 downto 0);
    signal s3, s2, s1, s0  : STD_LOGIC_VECTOR(7 downto 0);

    signal ones, tens      : natural range 0 to 9;

    signal led_temp   : std_logic_vector(7 downto 0) := (others => '0');
	signal blink_cnt  : integer range 0 to 10_000_000 := 0;
	signal blink_clk  : std_logic := '0';
    


    constant key   : std_logic_vector(3 downto 0) := "1010";

    constant BLANK : std_logic_vector(7 downto 0) := "11111111";
    constant P     : std_logic_vector(7 downto 0) := "10001100";
    constant A     : std_logic_vector(7 downto 0) := "10001000";
    constant S     : std_logic_vector(7 downto 0) := "10010010";


    function to_sevenSeg(d : natural) return std_logic_vector is
        begin
            case d is
                when 0 => return "11000000";
                when 1 => return "11111001";
                when 2 => return "10100100";
                when 3 => return "10110000";
                when 4 => return "10011001";
                when 5 => return "10010010";
                when 6 => return "10000010";
                when 7 => return "11111000";
                when 8 => return "10000000";
                when 9 => return "10010000";
                when others => return "11111111";
            end case;
    end function;        

begin


    correct_pass <= '1' when switch = key else '0';


    phase_switching: process (clk)
    begin
        if rising_edge(clk) then

            case phase is

                when 1 =>
                    if btn1 = '0' then
                        phase <= 2;
                    else
                        phase <= 1;    
                    end if;

                when 2 =>
                    if reachedTo15 = '1' then
                        phase <= 3;
                    else
                        phase <= 2;    
                    end if;

                when 3 =>
                    if correct_pass = '1' and btn2 = '0' then
                        phase <= 4;
                    elsif correct_pass = '1' and btn2 = '1' then    
                        phase <= 3;
                    else
                        phase <= 3;    
                    end if;


                when 4 =>
                    if correct_pass = '0' then
                        phase <= 3;
                    end if;
                           
                when others =>
                    phase <= 1;

            end case;    
        end if;    
    end process;


    counter0_15: process(clk)
    begin
        if rising_edge(clk) then
            counter_cnt <= counter_cnt + 1;

            if counter_cnt >= 24_999_999 then
                counter_cnt <= 0;

                if phase = 2 and reachedTo15 = '0' then
                    if counter = 15 then
                        counter <= 0;
                        reachedTo15 <= '1';                        
                    else
                        counter <= counter + 1;

                    end if;
                end if;

            end if;
        end if;
    end process;


    pass_animation: process(clk)
    begin
        if rising_edge(clk) then
            state_cnt <= state_cnt + 1;

            if state_cnt = 25_000_000 then
                state_cnt <= 0;

                if phase = 4 then

                    if correct_pass = '0' then
                        state <= 0;

                    elsif btn2 = '0' then

                        if state >= 7 then
                            state <= 0;
                        else
                            state <= state + 1;
                        end if;
                        
                    end if;

                else
                    state <= 0;

                end if;

            end if;    
                           
        end if; 

    end process;

   

    
    seven_segment_Select: process(clk)
    begin
        if rising_edge(clk) then
			sevenSeg_cnt <= sevenSeg_cnt + 1;
				
            if sevenSeg_cnt >= 49_999 then
                sevenSeg_cnt <= 0;

                if sevenSeg_select = 3 then
                    sevenSeg_select <= 0;
                else
                    sevenSeg_select <= sevenSeg_select + 1;
                end if;

            end if;    

        end if;
    end process;


    seven_segment_values: process(counter, phase, state, correct_pass)
    begin
    
        if phase = 1 then    
            s0 <= to_sevenSeg(2);
            s1 <= to_sevenSeg(8);
            s2 <= to_sevenSeg(3);
            s3 <= to_sevenSeg(4);
            
        elsif phase = 2 then    
            s3 <= to_sevenSeg(counter mod 10);
            s2 <= to_sevenSeg(counter / 10);
            s1 <= to_sevenSeg(10);
            s0 <= to_sevenSeg(10);

        elsif phase = 3 then    
            if correct_pass = '1' then
                s3 <= S;    
                s2 <= S;    
                s1 <= A;    
                s0 <= P;    
            else
                s0 <= BLANK;
                s1 <= BLANK;
                s2 <= BLANK;
                s3 <= BLANK;
        end if;
            
				
        elsif phase = 4 then    
            case state is
                when 0 =>
                    s3 <= S;     
                    s2 <= S;     
                    s1 <= A;     
                    s0 <= P;     
    
                when 1 =>
                    s3 <= S;     
                    s2 <= A;     
                    s1 <= P;     
                    s0 <= BLANK; 
    
                when 2 =>
                    s3 <= A;     
                    s2 <= P;     
                    s1 <= BLANK; 
                    s0 <= BLANK; 
    
                when 3 =>
                    s3 <= P;     
                    s2 <= BLANK; 
                    s1 <= BLANK; 
                    s0 <= BLANK; 
    
                when 4 =>
                    s3 <= BLANK; 
                    s2 <= BLANK; 
                    s1 <= BLANK; 
                    s0 <= BLANK; 
    
                when 5 =>
                    s3 <= BLANK; 
                    s2 <= BLANK; 
                    s1 <= BLANK; 
                    s0 <= S;     
                    
                when 6 =>
                    s3 <= BLANK; 
                    s2 <= BLANK; 
                    s1 <= S;     
                    s0 <= S;     
    
                when 7 =>
                    s3 <= BLANK; 
                    s2 <= S;     
                    s1 <= S;     
                    s0 <= A;     
    
                when others =>
                    s3 <= BLANK;   
                    s2 <= BLANK;
                    s1 <= BLANK;
                    s0 <= BLANK; 
            end case;

            else
                s0 <= BLANK;   
                s1 <= BLANK;
                s2 <= BLANK;
                s3 <= BLANK;             
        end if;
    end process;


    seven_segment_display: process(sevenSeg_select, s0, s1, s2, s3)
    begin
        case sevenSeg_select is
            when 0 =>
                an <= "1110";
                sevenSeg_temp <= s0;
    
            when 1 =>
                an <= "1101";
                sevenSeg_temp <= s1;
    
            when 2 =>
                an <= "1011";
                sevenSeg_temp <= s2;
    
            when 3 =>
                an <= "0111";
                sevenSeg_temp <= s3;
    
            when others =>
                an <= "1111";
                sevenSeg_temp <= "11111111";
        end case;
    
        sevenSeg <= sevenSeg_temp;
    end process;


    blinker_clk: process(clk)
	begin
		if rising_edge(clk) then
			blink_cnt <= blink_cnt + 1;

			if blink_cnt = 10_000_000 then   
				blink_cnt <= 0;

				blink_clk <= not blink_clk;
			end if;
		end if;
	end process;


    wrong_pass_led: process(correct_pass, phase, blink_clk)
	begin
		
		if phase = 3 and correct_pass = '0' then
			if blink_clk = '1' then
				 led_temp <= (others => '1');
			else
				 led_temp <= (others => '0');
			end if;

            else 
                led_temp <= (others => '0');    
		end if;

        led <= led_temp;
	end process;

end Behavioral;