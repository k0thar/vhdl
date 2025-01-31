library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fa8bit_beh is 
Port(
    aa,bb:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    ccin:IN STD_LOGIC;
    ss:out STD_LOGIC_VECTOR(7 DOWNTO 0);
    ccout:OUT STD_LOGIC
);
end fa8bit_beh;

ARCHITECTURE Behavioral of fa8bit_beh is
COMPONENT fa_beh 
PORT(
    A : in  STD_LOGIC;
    B : in  STD_LOGIC;
    C_in : in  STD_LOGIC;
    Sum : out  STD_LOGIC;
    C_out : out  STD_LOGIC
);
end COMPONENT;

signal cc: STD_LOGIC_VECTOR(6 DOWNTO 0);

begin

    FA1: fa_beh PORT MAP(aa(0), bb(0), ccin, ss(0), cc(0));
    FA2: fa_beh PORT MAP(aa(1), bb(1), cc(0), ss(1), cc(1));
    FA3: fa_beh PORT MAP(aa(2), bb(2), cc(1), ss(2), cc(2));
    FA4: fa_beh PORT MAP(aa(3), bb(3), cc(2), ss(3), cc(3));
    FA5: fa_beh PORT MAP(aa(4), bb(4), cc(3), ss(4), cc(4));
    FA6: fa_beh PORT MAP(aa(5), bb(5), cc(4), ss(5), cc(5));
    FA7: fa_beh PORT MAP(aa(6), bb(6), cc(5), ss(6), cc(6));
    FA8: fa_beh PORT MAP(aa(7), bb(7), cc(6), ss(7), ccout);
    
end Behavioral;
