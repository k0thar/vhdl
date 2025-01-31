LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY fa_stru IS
PORT(
    a ,b ,cin : IN STD_LOGIC;
    s ,cout :OUT STD_LOGIC
);
END;

ARCHITECTURE arch_fa_stru OF fa_stru IS

BEGIN

s <= a XOR b XOR cin;

cout <= (a and b)or (a and cin) or (cin and b);
END arch_fa_stru;
