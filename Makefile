

PROJECTFOLDER = rota
GODOTFOLDER = godot
GODOTCPPFOLDER = godot-cpp

#estragon
estragon :
	echo "using estragon" ;

all : godot


#
# editor : Build godot editor with specific options using estragon
#
godot : estragon
	#. ./gitcommand.sh && pull_godot ;
	python3 estragon/estragon_build_godot.py "$(PWD)"/godot target=release_debug;
	ln -sf ./godot/bin/godot.x11.tools.64 ./godoteditor.bin ;
	
git_pull:
	pull_subtrees ;


godot-cpp: godot
	git clone --recursive https://github.com/GodotNativeTools/godot-cpp 
	python3 estragon/estragon_build_godot.py "$(PWD)"/"$(GODOTCPPFOLDER)" target=release_debug;
	
	
	

cpp_bindings: godot
	
	
	
project : godot cpp_bindings	
	
