# Drummey

## About
A simple drum simulator called Drummey. Inside the program the user can choose between 3 different
drum layouts. To play just press the displayed key on the keyboard.

## Get Started
To start Drummey you need Processing Version 3.5.4 and Sonic Pi Version 3.3.1. In case you want to
record a session, go to the data folder and set your save path in the savePath.json. Format the save path like
the example in the json file (backslashes become slashes) and always end it with a slash. 
First of all open Drummey.rb with Sonic Pi and run the code inside. Then open Drummey.pde 
and start the sketch. It's necessary that the Sonic Pi code is already running before starting the 
sketch in Processing. Otherwise the program will not work.

## To Do's
Pending:
- add a reset button for sound settings (future)
- add fx like reverb, distortion or compressor (future)

Finished:
- connect Processing to Sonic Pi 🗸
- change color scheme 🗸
- create drum overlays (jazz, rock, fusion) 🗸
- implement different drum layouts 🗸
- implement buttons to switch drum layouts 🗸
- add volume knob and more settings knobs 🗸
- record/save function 🗸

## Software
- Processing https://processing.org/de/
- Sonic Pi https://sonic-pi.net/

## Dependencies
- controlP5 https://sojamo.de/libraries/controlP5/
- oscP5 https://sojamo.de/libraries/oscP5/

## Sources
- record/save solution https://in-thread.sonic-pi.net/t/recording-is-not-happening-with-osc-commands/4710

## Thanks
@Brian-Farmer for useful input and advices
