LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;



ENTITY nbitaddr IS
    GENERIC( n :integer:=4);
    PORT(
        CIN:IN STD_LOGIC;
        A,B:IN STD_LOGIC_VECTOR(n-1 downto 0);
        S:OUT STD_LOGIC_VECTOR(n-1 downto 0);
        COUT:OUT STD_LOGIC
    );
END nbitaddr;

ARCHITECTURE arch_nbitaddr OF nbitaddr IS
    COMPONENT fa
    PORT(
        a, b, cin : IN STD_LOGIC;
        sum, cout : OUT STD_LOGIC
    );
    END COMPONENT;
    SIGNAL C:STD_LOGIC_VECTOR(n-2 downto 0);

    BEGIN
    fa1:fa PORT MAP(A(0),B(0),CIN,S(0),C(0));
    gen: FOR i IN n-2 downto 1 GENERATE 
        fai:fa PORT MAP (A(i),B(i),C(i-1),S(i),C(i));
    END GENERATE;
    faL:fa PORT MAP(A(n-1),B(n-1),C(n-2),S(n-1),COUT);
END arch_nbitaddr;
    