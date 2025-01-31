LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY fa8bit_stru IS
    PORT(
        aa, bb : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        ccin   : IN STD_LOGIC;
        ss     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        ccout  : OUT STD_LOGIC
    );
END fa8bit_stru;

ARCHITECTURE arch_fa8bit_stru OF fa8bit_stru IS
    COMPONENT fa_stru
        PORT(
            a, b, cin : IN STD_LOGIC;
            s, cout   : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL cc : STD_LOGIC_VECTOR(6 DOWNTO 0);  

BEGIN
    FA1: fa_stru PORT MAP(aa(0), bb(0), ccin, ss(0), cc(0));
    FA2: fa_stru PORT MAP(aa(1), bb(1), cc(0), ss(1), cc(1));
    FA3: fa_stru PORT MAP(aa(2), bb(2), cc(1), ss(2), cc(2));
    FA4: fa_stru PORT MAP(aa(3), bb(3), cc(2), ss(3), cc(3));
    FA5: fa_stru PORT MAP(aa(4), bb(4), cc(3), ss(4), cc(4));
    FA6: fa_stru PORT MAP(aa(5), bb(5), cc(4), ss(5), cc(5));
    FA7: fa_stru PORT MAP(aa(6), bb(6), cc(5), ss(6), cc(6));
    FA8: fa_stru PORT MAP(aa(7), bb(7), cc(6), ss(7), ccout);

END arch_fa8bit_stru;
