# Copyright (c) 2020 Noé Perard-Gayot. All rights reserved.
# This work is licensed under the terms of the MIT license. 
# For a copy, see <https://opensource.org/licenses/MIT>.

##
## Makefile to build all rota and related projects 
##

##
## stored variable
##
PROJECT_FOLDER = navis

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
.SILENT: all editor estragon submodules $(GODOT_BIN) $(PROJECT_FOLDER) 

##
##  build what we need to start working
##
all : godot estragon $(PROJECT_FOLDER)

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
estragon : 

##
## godot-cpp repository
## godot headers and data for gdnative support
##
#godot-cpp : godot-cpp/bin
#godot-cpp/bin : estragon godot 
#	$(GODOT_BIN)  --gdnative-generate-json-api api.json
#	python3 estragon/estragon_godot_cpp.py "$(PWD)/$(GODOT_CPPFOLDER)" $(TARGET) #"use_custom_api_file=yes custom_api_file=../api.json";

##
## editor : the godot engine
## Build godot editor with specific options using estragon
##
godot : $(GODOT_BIN)
## actual rule to make sure we run every time
$(GODOT_BIN) : build_godot
	python3 estragon/estragon_build_godot.py $(PWD)/godot $(TARGET);
	rm "$(GODOT_BIN)" || true
	find $(GODOT_FOLDER)/bin -name '*tools*' |xargs -I {} ln -s {} "$(GODOT_BIN)"
	chmod +x $(GODOT_BIN)

build_godot : estragon
	python3 estragon/estragon_build_godot.py $(PWD)/godot $(TARGET);
	rm "$(GODOT_BIN)" || true
	find $(GODOT_FOLDER)/bin -name '*tools*' |xargs -I {} ln -s {} "$(GODOT_BIN)"
	chmod +x $(GODOT_BIN)

##
## Project :
## Our code and related objects
##
$(PROJECT_FOLDER) :  godot estragon project
project : 
	# no gd native 
	# python3 estragon/estragon_gdnative.py $(PWD)/$(PROJECT_FOLDER) $(TARGET);


##
## Clean everything, start from scratch
##
clean :
	rm -f "$(GODOT_BIN)"
	rm -f "$(GODOT_FOLDER)/bin/*" 
	
	
	
	
