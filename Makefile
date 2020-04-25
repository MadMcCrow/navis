# Copyright (c) 2020 Noé Perard-Gayot. All rights reserved.
# This work is licensed under the terms of the MIT license. 
# For a copy, see <https://opensource.org/licenses/MIT>.

##
## Makefile to build all rota and related projects 
##

##
## stored variable
##
PROJECT_FOLDER = rota

GODOT_CPPFOLDER = godot-cpp
GODOT_BIN = ./godot-editor.bin
GODOT_FOLDER = godot
GODOT_REMOTE = "https://github.com/MadMcCrow/godot.git"
GODOT_BRANCH = "master"

ESTRAGON_REMOTE = "https://github.com/MadMcCrow/estragon.git"
ESTRAGON_BRANCH = "production"

TARGET ="target=debug"


##
## Remove make output
##
.SILENT: all godot-cpp editor estragon submodules

##
##  build what we need to start working
##
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
	python3 estragon/estragon_godot_cpp.py "$(PWD)/$(GODOT_CPPFOLDER)" $(TARGET);
	$(GODOT_BIN)  --gdnative-generate-json-api api.json


##
## editor : the godot engine
## Build godot editor with specific options using estragon
##
godot : editor
## actual rule to make sure we run every time to 
editor : estragon
	#. ./gitcommand.sh && pull_godot ;
	python3 estragon/estragon_build_godot.py $(PWD)/godot $(TARGET);
	#for file in ./godot/bin/* ;do echo "${file} -> ${file#.*.}" ; done
	rm "$(GODOT_BIN)" || true
	ln -s "$(GODOT_FOLDER)/bin/godot.x11.tools.64" "$(GODOT_BIN)";
	chmod +x $(GODOT_BIN)
	

##
## Project :
## Our code and related objects
##
project : godot estragon godot-cpp 
	# first let's build our gdnative code
	python3 estragon/estragon_gdnative.py $(PWD)/$(PROJECT_FOLDER) $(TARGET);


##
## Clean everything, start from scratch
##
clean :
	rm -f "$(GODOT_BIN)"
	rm -f "$(GODOT_FOLDER)/bin/*" 
	
	
	
	
