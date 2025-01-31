LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fa IS
    PORT (
        a, b, cin : IN STD_LOGIC;
        sum, cout : OUT STD_LOGIC
    );
END fa;

ARCHITECTURE fa_arch OF fa IS 
BEGIN
    sum <= a XOR b XOR cin
    cout <= (a AND b)OR (b AND cin) OR(a AND cin)
END fa_arch;
