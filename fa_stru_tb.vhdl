LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fa_stru_tb IS
END ENTITY;

ARCHITECTURE test OF fa_stru_tb IS
    COMPONENT fa_stru
        PORT(
            a, b, cin : IN STD_LOGIC;
            s, cout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL a, b, cin, s, cout : STD_LOGIC;

BEGIN
    uut : fa_stru PORT MAP(
        a => a,
        b => b,
        cin => cin,
        s => s,
        cout => cout
    );

    PROCESS
    BEGIN
        a <= '0'; b <= '0'; cin <= '0';
        WAIT FOR 10 ns;
        
        a <= '0'; b <= '0'; cin <= '1';
        WAIT FOR 10 ns;
        
        a <= '0'; b <= '1'; cin <= '0';
        WAIT FOR 10 ns;
        
        a <= '0'; b <= '1'; cin <= '1';
        WAIT FOR 10 ns;
        
        a <= '1'; b <= '0'; cin <= '0';
        WAIT FOR 10 ns;
        
        a <= '1'; b <= '0'; cin <= '1';
        WAIT FOR 10 ns;
        
        a <= '1'; b <= '1'; cin <= '0';
        WAIT FOR 10 ns;
        
        a <= '1'; b <= '1'; cin <= '1';
        WAIT FOR 10 ns;
        
        ASSERT false REPORT "END OF TEST" SEVERITY note;
        WAIT;
    END PROCESS;
END ARCHITECTURE;
