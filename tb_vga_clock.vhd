---VGA clock divider testbench----
---Author: José Borja Castillo Sánchez---

library ieee;
use ieee.std_logic_1164.all;

entity tb_vga_clock is
end entity ; -- tb_vga_clock

architecture arch of tb_vga_clock is
	signal tb_clk_in,tb_clk_out: std_logic;
begin
	FREQ: entity work.vga_clock port map(tb_clk_in,tb_clk_out);
	process
	begin
		tb_clk_in <= '0', '1' after 10 ns;
		wait for 20 ns;
	end process;
end architecture ; -- arch