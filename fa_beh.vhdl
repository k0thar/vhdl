library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fa_beh is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C_in : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           C_out : out  STD_LOGIC);
end fa_beh;

architecture Behavioral of fa_beh is

begin
process(A, B, C_in)
begin
if A = '1' and B = '1' and C_in = '0' then
	Sum <= '0';
	C_out <= '1';
elsif A = '1' and B = '0' and C_in = '0' then
	Sum <= '1';
	C_out <= '0';
elsif A = '0' and B = '1' and C_in = '0' then
	Sum <= '1';
	C_out <= '0';
elsif A = '0' and B = '0' and C_in = '0' then
	Sum <= '0';
	C_out <= '0';
elsif A = '1' and B = '1' and C_in = '1' then
	Sum <= '1';
	C_out <= '1';
elsif A = '1' and B = '0' and C_in = '1' then
	Sum <= '0';
	C_out <= '1';
elsif A = '0' and B = '1' and C_in = '1' then
	Sum <= '0';
	C_out <= '1';
elsif A = '0' and B = '0' and C_in = '1' then
	Sum <= '1';
	C_out <= '0';
end if;

end process;

end Behavioral;