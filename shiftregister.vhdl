library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY shiftregister IS
    GENERIC (
        n : integer := 4  
    );
    PORT (
        input   : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        clock : IN STD_LOGIC;
serial_right: in std_logic;
serial_left : in std_logic;
        s0,s1 : IN STD_LOGIC;  
        output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
    );
END shiftregister;

ARCHITECTURE structural OF shiftregister IS

   
    COMPONENT Dff IS
        PORT (
            D   : IN  STD_LOGIC;
            clk : IN  STD_LOGIC;
            Q   : INOUT STD_LOGIC;
            nQ  : INOUT STD_LOGIC
        );
    END COMPONENT;
 
component mux4x1 IS
PORT (
        i0, i1, i2, i3 : IN STD_LOGIC;
        S1, S0 : IN STD_LOGIC;
        Y : OUT STD_LOGIC
    );
END component;

signal muxout, dffout, not_dffout : std_logic_vector(n-1 downto 0);

begin

mux0: mux4x1 port map(i0=>input(0), i1=>serial_right, i2=>dffout(1), i3=>dffout(0), S1=>s1,S0=>s0,Y=>muxout(0));

midMux: for i in 1 to n-2 generate
mux_i : mux4x1 port map(
i0=>input(i),
i1=>dffout(i+1),
i2=>dffout(i-1),
i3=>dffout(i),
S1=>s1,
S0=>s0,
Y=>muxout(i)
);
end generate;

muxlast: mux4x1 port map(i0=>input(n-1), i1=>serial_left, i2=>dffout(n-2), i3=>dffout(n-1), S1=>s1,S0=>s0,Y=>muxout(n-1));



dffs: for i in 0 to n-1 generate
dff_i : dff port map (
D=>muxout(i),
clk=>clock,
Q=>dffout(i),
nQ=>not_dffout(i)

);
end generate;

output <= dffout;

END structural;




LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4x1 IS
    PORT (
        I0, I1, I2, I3 : IN STD_LOGIC;
        S1, S0 : IN STD_LOGIC;
        Y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE structural OF mux4x1 IS
    COMPONENT mux2x1 is
    Port ( I0 : in  STD_LOGIC;
           I1 : in  STD_LOGIC;
           s : in  STD_LOGIC;
           Y : out  STD_LOGIC);

    END COMPONENT;

    SIGNAL mid0, mid1 : STD_LOGIC;
BEGIN

    mux0 : mux2x1 PORT MAP(I0, I1, S0, mid0);
    mux1 : mux2x1 PORT MAP(I2, I3, S0, mid1);
    mux2 : mux2x1 PORT MAP(mid0, mid1, S1, Y);

END structural;






library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux2x1 is
    Port ( I0 : in  STD_LOGIC;
           I1 : in  STD_LOGIC;
           s : in  STD_LOGIC;
           Y : out  STD_LOGIC);
end mux2x1;

architecture Structural of mux2x1 is

signal temp0, temp1 , n_s : std_logic;

begin
n_s<= not s;
temp0 <= I0 and n_s;
temp1 <= I1 and s;
Y <= temp0 or temp1;

end Structural;







library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Dff is
    Port(
        D   : in std_logic;        -- Data input to the flip-flop
        clk : in std_logic;        -- Clock signal
        Q   : inout std_logic := '0'; -- Output of the flip-flop
        nQ  : inout std_logic := '1'  -- Complementary output (not-Q)
    );
end Dff;

architecture Structural of Dff is

    -- Component Declaration for Dlatch (used to build the flip-flop)
    COMPONENT Dlatch
        Port(
            d   : in std_logic;       -- Data input for the latch
            e   : in std_logic;       -- Enable signal (clock signal)
            Q   : inout std_logic;    -- Latch output
            nQ  : inout std_logic     -- Complementary latch output
        );
    END COMPONENT;

    -- Signals to hold intermediate values
    signal L1 : std_logic := '0';  -- Signal to hold intermediate latch value
    signal nclk : std_logic := '0'; -- Inverted clock signal

begin

    -- Generate the inverted clock for the first latch
    nclk <= not clk;

    -- First Dlatch component (using nclk)
    d_l1: Dlatch
        port map (
            d => D,       -- Input D to the latch
            e => nclk,    -- Enable input (inverted clock)
            Q => L1,      -- Output of the first latch
            nQ => open    -- Unused nQ from the first latch
        );

    -- Second Dlatch component (using clk)
    d_l2: Dlatch
        port map (
            d => L1,      -- Data from the first latch
            e => clk,     -- Enable input (original clock)
            Q => Q,       -- Final output Q
            nQ => nQ      -- Complementary output nQ
        );

end Structural;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Dlatch is
    Port(
        d   : in std_logic;   -- Data input
        e   : in std_logic;   -- Enable (clock or control signal)
        Q   : inout std_logic; -- Output of the latch
        nQ  : inout std_logic  -- Complementary output (not-Q)
    );
end Dlatch;

architecture Structural of Dlatch is
    signal s1, s2, nD : std_logic;
begin

    -- Generate the internal signals using NAND gates
    s1 <= d nand e;  -- First part of the latch logic
    nD <= d nand d;  -- Feedback path for the latch (cross-coupled)
    s2 <= nD nand e; -- Second part of the latch logic

    -- Define the latch using NAND gates for outputs
    Q <= s1 nand nQ;  -- Output Q
    nQ <= s2 nand Q;  -- Complementary output nQ (feedback loop)

end Structural;
