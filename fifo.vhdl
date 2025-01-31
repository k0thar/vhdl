library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO_Buffer is
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
end FIFO_Buffer;

architecture Behavioral of FIFO_Buffer is

    type shift_register_array is array (0 to DEPTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal shift_registers : shift_register_array := (others => (others => '0'));
    signal write_pointer : unsigned(log2ceil(DEPTH) - 1 downto 0) := (others => '0');
    signal read_pointer  : unsigned(log2ceil(DEPTH) - 1 downto 0) := (others => '0');
    signal fifo_count    : unsigned(log2ceil(DEPTH) downto 0) := (others => '0');

    signal internal_full  : std_logic;
    signal internal_empty : std_logic;

    function log2ceil(n : integer) return integer is
        variable result : integer := 0;
        variable x : integer := n - 1;
    begin
        while x > 0 loop
            x := x / 2;
            result := result + 1;
        end loop;
        return result;
    end function;

begin

    process(clk, rst)
    begin
        if rst = '1' then
            write_pointer <= (others => '0');
            read_pointer <= (others => '0');
            fifo_count <= (others => '0');
            data_out <= (others => '0');
            shift_registers <= (others => (others => '0'));
        elsif rising_edge(clk) then
            -- Write operation
            if write_en = '1' and internal_full = '0' then
                shift_registers(to_integer(write_pointer)) <= data_in;
                write_pointer <= write_pointer + 1;
                fifo_count <= fifo_count + 1;
            end if;

            -- Read operation
            if read_en = '1' and internal_empty = '0' then
                data_out <= shift_registers(to_integer(read_pointer));
                read_pointer <= read_pointer + 1;
                fifo_count <= fifo_count - 1;
            end if;
        end if;
    end process;

    -- Flags
    internal_full <= '1' when fifo_count = DEPTH else '0';
    internal_empty <= '1' when fifo_count = 0 else '0';

    full <= internal_full;
    empty <= internal_empty;

end Behavioral;
