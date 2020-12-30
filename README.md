# ALTERA VGA Controller

## A simple VGA controller meant to be used with ALTERA FPGAs
This project is intended to be used with [Terasic DE-10 Lite](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=1021) since it uses a 4 bit RGB color space.

Data lines are not implemented and resolution is fixed to standard VGA values, 640x480 at 60 Hz.

## Files
```
+- rtl/
| -- pll.vhd 		              : PLL component to generate main clock.
| -- pll_inst.vhd               : Example instance of PLL component, generated by Quartus.
| -- vga_controller.vhd         : Main file, top module for the project.
| -- vga_pattern_generator.vhd  : Pattern generator to test colour functionality.
| -- vga_sync.vhd               : Module created to generate sync signals.
+- test/
| -- stims.do                   : Stimulus file for simulation.
+- pics/
| -- resolution.jpg
| -- test_bars.jpg
```

## Notes

The pattern generator and sync signals are intended to be used with the resolution given, although it is quiet simple to change. Generics may solve this issue.

All the files were compiled and implemented in Quartus 20.1 lite, simulation took place in Modelsim starter edition. To simulate the sync signals, text: do stims.do

In order to implement all the compulsory signals, plese refer to the board's manual.

## LICENCE

This project is licensed under the GNU license.