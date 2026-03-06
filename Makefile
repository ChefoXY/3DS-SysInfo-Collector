#---------------------------------------------------------------------------------
# RUTAS
#---------------------------------------------------------------------------------
DEVKITPRO := C:/devkitPro
DEVKITARM := $(DEVKITPRO)/devkitARM
LIBCTRU   := $(DEVKITPRO)/libctru

# Importante: Esto carga las reglas mágicas de Nintendo
include $(DEVKITARM)/3ds_rules

#---------------------------------------------------------------------------------
# CONFIGURACIÓN
#---------------------------------------------------------------------------------
TARGET      := 3DS-SysInfo-Collector
SOURCES     := source
INCLUDES    := include
BUILD       := build
LIBS        := -lctru -lm

# Flags de arquitectura y compilación
ARCH    := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
CFLAGS  := -g -Wall -O2 -mword-relocations $(ARCH) -I$(LIBCTRU)/include -I$(CURDIR)/$(INCLUDES)
# Agregamos LDFLAGS para que el linker sepa que es una app de 3DS
LDFLAGS := $(ARCH) -specs=3dsx.specs -L$(LIBCTRU)/lib

#---------------------------------------------------------------------------------
# REGLAS
#---------------------------------------------------------------------------------
.PHONY: all clean

all: $(TARGET).3dsx

# Genera el 3DSX desde el ELF
$(TARGET).3dsx: $(TARGET).elf

# El paso crítico: Enlazar usando las specs de 3DS
$(TARGET).elf: $(SOURCES)/main.c
	@mkdir -p $(BUILD)
	arm-none-eabi-gcc $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
	@echo "¡Enlazado de sistema completado!"

clean:
	@rm -rf $(BUILD) $(TARGET).elf $(TARGET).3dsx
	@echo "Limpieza completada."