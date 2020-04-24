

PROJECTFOLDER = rota
GODOTFOLDER = godot
GODOTCPPFOLDER = godot-cpp
GODOT_BIN = ./godoteditor.bin 

all : godot

#estragon tool
estragon : submodules

# godot headers for gdnative
godot-cpp : submodules estragon godot
	python3 estragon/estragon_godot_cpp.py "$(PWD)"/"$(GODOTCPPFOLDER)" target=release_debug;
	"$(GODOT_BIN)"  --gdnative-generate-json-api api.json


#
# editor : Build godot editor with specific options using estragon
#
godot : estragon
	#. ./gitcommand.sh && pull_godot ;
	python3 estragon/estragon_build_godot.py "$(PWD)"/godot target=release_debug;
	ln -sf ./godot/bin/godot.x11.tools.64 "$(GODOT_BIN)" ;
	
# get all project's submodules
submodules:
	git submodule update --init --recursive


project : godot estragon	
	
