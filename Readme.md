AGTEX is a Jacquard punching card tool software solution,
It contains all the required tools integrated into one set

The following lists all the features in the AGTEX.
GC-Punch: Designed for the AG-TEX this was the first industrial project undertaken.
It was an end to end system development for Jacquard Punching card system which 
included development of interfacing board for the legacy system i.e the control net and a 
fully-fledged software tool that incorporates works and not limited to perform bit 
manipulation of the image, image to card layout conversion as addressed below.,

 *. Fast Lane Project with 1 month development time and 1 month testing.

 *. Complete image to card solution, unique in industry

 *. Built as two models

		*. Version-1 as simplistic and tightly constrained to get maximum out of GPIO and I2C pins with ATMega8

		*. Version-2 was designed using ATMega2560 to have higher degree of flexibility and much more real-time response.

 *. UI was built on GUIDE with Mathworks Matlab.

 *. Backend Code handling was done on Matlab and ported to .Net C#.

 *. Associated work includes PCB design and fabrication which was a shield 
for Arduino Mega2560

 *. Legacy System was analysed to be digitally rewired using DSLogix Pro.

 *. Deployment has been done using WiX – Windows Installer XML.

 *. Unique Hardware Locking on the Microcontroller to avoid tampering.

 *. Standalone no-computer required for servicing, testing and test-card 
printing.

 *. Auto Rack Reset to prevent mechanical rack dislodging.

 *. Extensibility option to print card numbers.

 *. Various security features including auto-stop on card breakage, card 
blockage or card mismatch.

 *. Auto-Card Layout detection and selection for any template image size.

 *. Custom Card layout functionality for user defined card layouts.

 *. Fully compatible keyboard shortcuts for software device testing.

 *. Supports OS from XP to Windows-X

 *. x64 as well as x86 compatible.

 *. Fully Customizable print head punch pattern.

 *. Custom Card printing for missing designs and broken cards.

 *. Card advance and recede options for quick seek and printing.

 *. Emergency Holes for added design benefits.

 *. Auto Lacing Detection and addition for cards of higher pin count.

 *. One click updateable firmware for future releases.

Since most of the existing customers of AG-TEX had a legacy control-net and were using 
DOS based machine, the key conditions that were taken to the drawing table were

1. Keep the user experience simple and in-close relation to that of one which was 
already existing.
2. Minimum/No hardware changes to the existing control net.
3. Simple and Low-power consumption hardware addition for the interface.

Keeping the above requirement as the priority guidelines the design was drawn, the initial 
prototyping was done using AT-Mega 8 / 328 to minimize the cost and footprint of the 
interface board, the testing was done successfully under first 15days of the project 
development lifecycle.

Once the client FS requirement was thawed to address the need of a physical keypad by 
the customers to allow quick access to the testing functionality on a standalone system, 
the device was redesigned to work with ATMEGA-2560 microcontroller there by 
providing additional functionalities of displaying current actions on a LCD display and 
provide the indication lights for software/hardware modes of operation.