---VGA pattern generator---
---Author: José Borja Castillo Sánchez---
---Notes:---
---A VGA (640x480) pattern generator---

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity vga_pattern_generator is port(
	clock : in std_logic;
	sync : in std_logic;
	pix_x : in integer;
	pix_y : in integer;
	red : out std_logic_vector(3 downto 0):="0000";
	green : out std_logic_vector(3 downto 0):="0000";
	blue : out std_logic_vector(3 downto 0):="0000");
end vga_pattern_generator;


architecture rtl_pattern_generator of vga_pattern_generator is 


begin 

	process(clock)
	begin
		
		if(rising_edge(clock)) then
			
			if sync = '1' then
				--Black pattern used for leveling
				red <= (others=>'0');
				green <= (others=>'0');
				blue <= (others=>'0');
			elsif (sync = '0') and (pix_x < 160) and (pix_x >= 0) then
			--Cyan colour
				red <= (others=>'0');
				green <= (others=>'0');
				blue <= (others=>'1');
			elsif (sync = '0') and (pix_x > 159) and (pix_x < 320) then
			--Magenta colour
				red <= (others=>'1');
				green <= (others=>'0');
				blue <= "0111";
			elsif (sync = '0') and (pix_x > 319) and (pix_x < 480) then
			--Yellow colour
				red <= (others=>'1');
				green <= (others=>'1');
				blue <= (others=>'0');
			elsif (sync = '0') and (pix_x > 479) then 
			--Black colour
				red <= (others=>'0');
				green <= (others=>'0');
				blue <= (others=>'0');
			end if;

		end if;

	end process;



end rtl_pattern_generator;