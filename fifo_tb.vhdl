library IEEE;
include "fifo.vhdl";
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FIFO_Buffer_tb is
end FIFO_Buffer_tb;

architecture Behavioral of FIFO_Buffer_tb is

    constant DATA_WIDTH : integer := 8;
    constant DEPTH      : integer := 2;

    -- Component declaration for the DUT (Device Under Test)
    component FIFO_Buffer
        generic (
            DATA_WIDTH : integer := 8;
            DEPTH      : integer := 2
        );
        port (
            clk        : in  std_logic;
            rst        : in  std_logic;
            write_en   : in  std_logic;
            read_en    : in  std_logic;
            data_in    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
            data_out   : out std_logic_vector(DATA_WIDTH-1 downto 0);
            full       : out std_logic;
            empty      : out std_logic
        );
    end component;




    -- Signals to connect to the DUT
    signal clk        : std_logic := '0';
    signal rst        : std_logic := '0';
    signal write_en   : std_logic := '0';
    signal read_en    : std_logic := '0';
    signal data_in    : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal data_out   : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal full       : std_logic;
    signal empty      : std_logic;

    -- Clock period
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the DUT
    DUT: FIFO_Buffer
        generic map (
            DATA_WIDTH => DATA_WIDTH,
            DEPTH      => DEPTH
        )
        port map (
            clk      => clk,
            rst      => rst,
            write_en => write_en,
            read_en  => read_en,
            data_in  => data_in,
            data_out => data_out,
            full     => full,
            empty    => empty
        );
 

    -- Clock generation process
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Test process
    stimulus_process: process
    begin
        -- Reset the FIFO
        rst <= '1';
        wait for CLK_PERIOD;
        rst <= '0';

--full test
for i in 0 to DEPTH-1 loop
data_in <= "10101010";
write_en <='1';
wait for CLK_PERIOD;
assert(full='1') report "FIFO can't write"severity error;
   
end loop;

-- empty test
write_en <= '0';
for i in 0 to DEPTH-1 loop
read_en <= '1';
wait for CLK_PERIOD;
assert (empty='1') report "FIFO is empty"severity error;
   
end loop;


read_en <= '0';
-- test one write
-- first reset the fifo
rst <= '1';
wait for CLK_PERIOD;
rst <= '0';
write_en <= '1';
data_in <= "11100000";
wait for CLK_PERIOD;
-- test one read
write_en <='0';
read_en <= '1';
wait for CLK_PERIOD;







        -- End simulation
        wait for CLK_PERIOD;
        wait;
    end process;

end Behavioral;