---VGA synchronization pattern generator ---
---Author: José Borja Castillo Sánchez---

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity vga_sync is
	generic(
			horizontal_pixels : integer := 640;
			horizontal_fp : integer := 16;
			horizontal_sync : integer := 96;
			horizontal_backp : integer := 48;
			horizontal_total : integer := 800;
			vertical_pixels : integer := 480;
			vertical_fp : integer := 10;
			vertical_sync : integer := 2;
			vertical_backp : integer := 33;
			vertical_total : integer := 525);
  port (
	clock: in std_logic;
	vsync, hsync: out std_logic := '1';
	hsync_active: out std_logic := '0';
	vsync_active: out std_logic := '0';
	pixel_x_loc : out integer := 0;
	pixel_y_loc : out integer := 0
  ) ;
end entity ; -- vga_sync

architecture arch of vga_sync is
	type pixel_state is (active_pixel,front_porch,sync_pulse,back_porch);
	signal hz_state : pixel_state := active_pixel;
	signal vz_state : pixel_state := active_pixel;
	signal horizontal_counter : integer range 0 to (horizontal_total-1) := 0;
	signal vertical_counter : integer range 0 to (vertical_total-1) := 0;
	signal new_line : std_logic := '1'; --active high
begin

	HZ_UPDATE: process(clock)
	begin
		if(rising_edge(clock)) then
			
			if(hz_state = active_pixel) then
				new_line <= '0';
				if(horizontal_counter = horizontal_pixels) then
					hz_state <= front_porch;
					horizontal_counter <= 0;
					pixel_x_loc <= 0;
				else
					pixel_x_loc <= horizontal_counter;
					horizontal_counter <= horizontal_counter + 1;
				end if;

			elsif(hz_state = front_porch) then
			
				if(horizontal_counter = horizontal_fp) then
						hz_state <= sync_pulse;
						horizontal_counter <= 0;
				else
						hsync_active <= '1';
						horizontal_counter <= horizontal_counter + 1;
				end if;
			
			elsif(hz_state = sync_pulse) then
				
				if(horizontal_counter = horizontal_sync) then
					hsync <= '1';
					hz_state <= back_porch;
					horizontal_counter <= 0;
				else
					hsync <= '0';
					horizontal_counter <= horizontal_counter + 1;
				end if;
				
			elsif(hz_state = back_porch) then

				if(horizontal_counter = horizontal_backp) then
					new_line <= '1';
					hsync_active <= '0';
					hz_state <= active_pixel;
					horizontal_counter <= 0;
				else
					--hsync_active <= '1';
					horizontal_counter <= horizontal_counter + 1;
				end if;
				
			end if;

		end if;		
	end process;

	VZ_UPDATE: process(clock,new_line)
	begin
		if(rising_edge(clock) and (new_line = '1') ) then


			if(vz_state = active_pixel) then 
				if(vertical_counter = vertical_pixels) then
					vertical_counter <= 0;
					pixel_y_loc <= 0;
					vz_state <= front_porch;	
				else
					vertical_counter <= vertical_counter + 1;
					pixel_y_loc <= vertical_counter;
				end if;

			elsif(vz_state = front_porch) then

				if(vertical_counter = vertical_fp) then
					vertical_counter <= 0;
					vz_state <= sync_pulse;
				else
					vsync_active <= '1';
					vertical_counter <= vertical_counter + 1;
				end if;

			elsif(vz_state = sync_pulse) then
				
				if(vertical_counter = vertical_sync) then
					vz_state <= back_porch;
					vertical_counter <= 0;
					vsync <= '1';
				else
					vsync <= '0';
					vertical_counter <= vertical_counter + 1;
				end if;

			elsif(vz_state = back_porch) then

				if(vertical_counter = vertical_fp) then
					vz_state <= active_pixel;
					vsync_active <= '0';
					vertical_counter <= 0;
				else
					vertical_counter <= vertical_counter + 1;
				end if;

			end if;

		end if;
	end process;

end;

