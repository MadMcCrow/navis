
#pragma once
//#ifndef GDEXAMPLE_H
//#define GDEXAMPLE_H

#include <Godot.hpp>
#include <Sprite.hpp>

namespace godot {

class GDMenuTest : public Sprite {
    GODOT_CLASS(GDMenuTest, Sprite)

private:
    float time_passed;

public:
    static void _register_methods();

    GDMenuTest();
    ~GDMenuTest();

    void _init(); // our initializer called by Godot

    void _process(float delta);
};

}

//#endif