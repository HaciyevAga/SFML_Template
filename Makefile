CC        := clang++
SRC_DIR   := src
BIN_DIR   := bin
BIN_EXE   := $(BIN_DIR)/sfmlgame
OUTPUT    := $(if $(findstring Window_Nt, $(OS)), $(BIN_EXE).exe, $(BIN_EXE))
OBJ_DIR   := $(BIN_DIR)/obj
INC_DIRS  := -I$(SRC_DIR) -I$(SFML_DIR)/include
LIB_DIRS  := -L$(SFML_DIR)/lib 
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
H_FILES   := $(wildcard $(SRC_DIR)/*.h)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC_FILES))
CPP_FLAGS := -O3 -std=c++17
LD_FLAGS  := -O3 -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio
# MAKEFLAGS := -j

# compile the object files and place them their own directory
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(H_FILES)
	$(CC) $(CPP_FLAGS) $(INC_DIRS) -c -o $@ $<

#link the object files together to create the final excutable
$(OUTPUT): $(OBJ_FILES) Makefile
	$(CC) $(LIB_DIRS) $(LD_FLAGS) $(OBJ_FILES) -o $(OUTPUT)

# When we type make, compile and link the excutable
all: $(OUTPUT)

# if we type 'make run' it will build and then run the excutable
run: $(OUTPUT)
	$(if $(findstring Window_Nt, $(OS)), cd bin && sfmlgame.exe && cd .., cd bin && ./sfmlgame && cd ..)

clean:
	$(if $(findstring Window_Nt, $(OS)), del cd\bin\*.o && del bin\sfmlgame.exe, rm $(OBJ_DIR)/*.o && rm $(OUTPUT))

