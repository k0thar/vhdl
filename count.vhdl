library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package count is
    function increament(x: integer) return integer; 
    function reset return integer;                
end package count;
package body count is
    function increament(x: integer) return integer is
    begin
        return x + 1;
    end function increament;

    function reset return integer is
    begin
        return 0;
    end function reset;
end package body count;
