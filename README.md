# cs3110_final_project
# How to play
1. Install the ocaml-raylib package via 
https://github.com/tjammer/raylib-ocaml/blob/master/README.md
Raylib has a few dependencies that must first be installed:
<code>sudo apt install libasound2-dev mesa-common-dev libx11-dev libxrandr-dev libxi-dev xorg-dev libgl1-mesa-dev libglu1-mesa-dev</code>
  Some of these dependencies have other dependencies including ALSA, Mesa, and X11.
https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux for more information.

2. There may be an error on windows laptops where there is an fatal error with opening the GUI. THis can be solved by the tutorial linked here: 
https://www.youtube.com/watch?v=4SZXbl9KVsw&ab_channel=RickMakes

Given that no one has a mac, we are not sure if the ocaml GUI will open on a mac

# Running the Code
to run the code, enter 
<code>make play</code>
into the terminal after opening the file.

# Documentation
can be built via
<code>make docs</code>
and found by navigating to /_build/default/_doc/_html/index.html
