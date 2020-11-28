-----VGA clock divider-----
---Author: José Borja Castillo Sánchez----


library ieee;
use ieee.std_logic_1164.all;
--other use

entity vga_clock is 
port(
	clk_in: in std_logic;
	clk_out: out std_logic
	);
end vga_clock;

architecture arch of vga_clock is

	signal temp: std_logic := '0';

begin

process(clk_in)
begin
	if(clk_in'event and clk_in = '1') then
		temp <= not temp;
	end if;
end process;

	clk_out <= temp;

end architecture ; -- arch