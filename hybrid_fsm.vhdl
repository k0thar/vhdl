library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.count.all;

entity hybrid_fsm is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        din : in STD_LOGIC;
        dout_moore : out STD_LOGIC;
        dout_mealy : out STD_LOGIC;
        count_out : out STD_LOGIC_VECTOR(3 downto 0)
    );
end hybrid_fsm;

architecture Behavioral of hybrid_fsm is
    type state_type is (S0, S1, S2, S3);
    signal current_state, next_state : state_type;
    signal counter : integer := 0;  
    signal moore_output : STD_LOGIC := '0';
    signal mealy_output : STD_LOGIC := '0';

begin
    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= S0;
            counter <= reset;  
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    process(clk)
    begin
        if current_state = S3 and din = '0' then
                counter <= counter+1;
        end if;
    end process;

    process(current_state, din)
    begin
        next_state <= S0;          
        mealy_output <= '0';       

        case current_state is
            when S0 =>
                if din = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;

            when S1 =>
                if din = '1' then
                    next_state <= S2;
                else
                    next_state <= S0;
                end if;

            when S2 =>
                if din = '0' then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;

            when S3 =>
                if din = '0' then
                    next_state <= S0;
                    mealy_output <= '1';  
                else
                    next_state <= S1;
                end if;
        end case;

        if current_state = S3 then
            moore_output <= '1';
        else
            moore_output <= '0';
        end if;
    end process;
    process(clk)
    begin
        if rising_edge(clk) then 
            count_out <= STD_LOGIC_VECTOR(to_unsigned(counter, 4));
        end if;
    end process;



    dout_moore <= moore_output;
    dout_mealy <= mealy_output;

end Behavioral;
