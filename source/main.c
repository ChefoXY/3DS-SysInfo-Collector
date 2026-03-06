#include <3ds.h>
#include <stdio.h>

int main() {
    // Encendemos motores graficos
    gfxInitDefault();

    // Configuramos la pantalla superior como terminal
    consoleInit(GFX_TOP, NULL);

    // Mensaje fijo
    printf("¡Hola, mundo!\n");
    printf("Pulsa START para salir!\n");

    // Bucle principal
    while (aptMainLoop()) {
        // Escanemos botones pulsados ahora
        hidScanInput();

        u32 kDown = hidKeysDown();

        // Si START se ha pulsado, salimos del bucle
        if (kDown & KEY_START) break;

        // Actualizamos pantalla
        gfxFlushBuffers();
        gfxSwapBuffers();
        gspWaitForVBlank();
    }

    // Apagamos todo antes de irnos
    gfxExit();
    return 0;
}