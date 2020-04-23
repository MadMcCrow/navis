#!/bin/bash


GODOTREMOTE="https://github.com/MadMcCrow/godot.git"
GODOTBRANCH="vulkan"
ESTRAGONREMOTE="https://github.com/MadMcCrow/estragon.git"
ESTRAGONBRANCH="production"
OPTIONS="--squash"

add_estragon(){
	git subtree add --prefix estragon $ESTRAGONREMOTE $ESTRAGONBRANCH $OPTIONS
}

add_godot(){
	git subtree add --prefix godot    $GODOTREMOTE    $GODOTBRANCH    $OPTIONS
}

add_subtrees()	{
	add_estragon ;
	add_godot ;
	}
	
	
pull_godot(){
	git subtree pull --prefix godot    $GODOTREMOTE    $GODOTBRANCH    $OPTIONS
}

pull_estragon(){
	git subtree pull --prefix godot    $GODOTREMOTE    $GODOTBRANCH    $OPTIONS
}
	
pull_subtrees(){
	pull_godot ;
	pull_estragon ;
}

push_subtree_estragon(){
	git subtree push --prefix estragon $ESTRAGONREMOTE $ESTRAGONBRANCH $OPTIONS
}

push_subtree_godot(){
	git subtree push --prefix godot    $GODOTREMOTE    $GODOTBRANCH    $OPTIONS
}



