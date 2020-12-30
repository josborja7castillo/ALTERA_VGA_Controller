---VGA Controller - Top level file---
---Author: José Borja Castillo Sánchez---

library ieee;
use ieee.std_logic_1164.all;

entity vga_controller is
  port (
	clock_in: in std_logic;
	R,G,B: out std_logic_vector(3 downto 0);
	HSYNC, VSYNC: out std_logic) ;
end entity ; -- vga_controller

architecture arch of vga_controller is

	component pll is port 
	(
		inclk0		: in std_logic  := '0';
		c0		: out std_logic 
	);
	end component;

	component vga_sync is port (
		clock: in std_logic;
		vsync, hsync: out std_logic := '0';
		hsync_active: out std_logic := '0';
		vsync_active: out std_logic := '0';
		pixel_x_loc : out integer := 0;
		pixel_y_loc : out integer := 0);
	end component;

	component vga_pattern_generator is port(
		clock : in std_logic;
		sync : in std_logic;
		pix_x : in integer;
		pix_y : in integer;
		red : out std_logic_vector(3 downto 0);
		green : out std_logic_vector(3 downto 0);
		blue : out std_logic_vector(3 downto 0));
	end component;

	signal pixel_clock: std_logic;
	signal clock_buffered: std_logic;
	signal no_pix_h, no_pix_v : std_logic;
	signal pix_x: integer range 0 to 640;
	signal pix_y: integer range 0 to 480;
	signal sync : std_logic;
	
	
	
begin
	pll_inst : pll PORT MAP (
		inclk0	 => clock_in,
		c0	 => pixel_clock
	);	

	VIDEO_SYNC: vga_sync port map(clock=>pixel_clock,
							vsync=>VSYNC,
							hsync=>HSYNC,
							hsync_active=>no_pix_h,
							vsync_active=>no_pix_v,
							pixel_x_loc=>pix_x,
							pixel_y_loc=>pix_y);

	sync <= no_pix_h or no_pix_v;

	VIDEO_PATTERN: vga_pattern_generator port map(clock=>pixel_clock,
											sync=>sync,
											pix_x=>pix_x,
											pix_y=>pix_y,
											red=>R,
											green=>G,
											blue=>B);


	--
end architecture ; -- arch