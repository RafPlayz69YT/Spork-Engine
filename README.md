# Friday Night Funkin': Spork Engine

this engine is gonna be the bestest engine ever!!!

html5 may be kinda goofy rn ill fix later dw dw

[play html5](https://rafplayz.tk/spork/index.html)
[download windows (sorry mac/linux users)](https://github.com/RafPlayz69YT/Spork-Engine/releases)




## how to compile lolololo

this is kinda like the og fnf one sooo yea 

### installing programs

download the programs below

1. [install haxe](https://haxe.org/download/)
2. [install haxeflixel](https://haxeflixel.com/documentation/install-haxeflixel/) after downloading haxe

you'll need to get these libraries
```
flixel
flixel-addons
flixel-ui
hscript (optional)
```
do `haxelib install [library]` eg `haxelib install flixel`

you'll need git to download some libraries
1. download [git-scm](https://git-scm.com/downloads), should work for all platforms
2. install it and then proceed to the next step
3. run `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` to install the discord rpc and that'll be it for libraries

### actually now compiling (to lazy to edit from og)
NOTE: If you see any messages relating to deprecated packages, ignore them. They're just warnings that don't affect compiling

Once you have all those installed, it's pretty easy to compile the game. You just need to run `lime test html5 -debug` in the root of the project and it'll auto boot the html5,


To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run `lime build linux -debug` and then run the executable file in export/release/linux/bin. 


For Windows, you need to install Visual Studio Community 2019. While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)
* 
Once that is done you can open up a command line in the project's directory and run `lime build windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin


As for Mac, 'lime build mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.


## Credits / shoutouts (og game)

- [ninjamuffin99 (me!)](https://twitter.com/ninja_muffin99) - Programmer
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r) - Art
- [Kawaisprite](https://twitter.com/kawaisprite) - Musician

This game was made with love to Newgrounds and its community. Extra love to Tom Fulp.