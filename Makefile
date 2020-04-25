PROJECTFOLDER = rota
GODOTFOLDER = godot
GODOTCPPFOLDER = godot-cpp
GODOT_BIN = ./godot-editor.bin

.SILENT: all godot-cpp editor estragon submodules

all : godot estragon project

##
## Submodules : "clone" all sub-repository
## get all project's submodules
##
submodules:
	git submodule update --init --recursive

##
## Estragon tool
## Will help us build, add code etc...
##
estragon : submodules

##
## godot-cpp repository
## godot headers and data for gdnative support
##
godot-cpp : submodules estragon godot
	python3 estragon/estragon_godot_cpp.py "$(PWD)/$(GODOTCPPFOLDER)" target=debug;
	$(GODOT_BIN)  --gdnative-generate-json-api api.json


##
## editor : the godot engine
## Build godot editor with specific options using estragon
##
godot : editor
## actual rule to make sure we run every time to 
editor : estragon
	#. ./gitcommand.sh && pull_godot ;
	python3 estragon/estragon_build_godot.py $(PWD)/godot target=debug;
	#for file in ./godot/bin/* ;do echo "${file} -> ${file#.*.}" ; done
	rm "$(GODOT_BIN)" || true
	ln -s "$(GODOTFOLDER)/bin/godot.x11.tools.64" "$(GODOT_BIN)";
	chmod +x $(GODOT_BIN)
	

##
## Project :
## Our code and related objects
##
project : godot estragon godot-cpp 


##
## Clean everything, start from scratch
##
clean :
	rm -f "$(GODOT_BIN)"
	rm -f "$(GODOTFOLDER)/bin/*" 
	
	
	
	
