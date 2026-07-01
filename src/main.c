#include <stdio.h>
#include "raylib.h"
#include "app.h"


int main() {

    InitWindow(800, 800, "Physics Lab");
    SetTargetFPS(60);

    App app = MENU;
    
    while (!WindowShouldClose()) {
        
        BeginDrawing();
        ClearBackground(WHITE);

        EndDrawing();
    }
    return 0;
}