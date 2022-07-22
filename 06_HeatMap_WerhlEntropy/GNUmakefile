TARGET = LMG
OBJ_DIR = obj
SRC_DIR = src
FLAGS1 = -g -Wall -fcheck=all
FLAGS2 = -L/usr/local/lib -llapack -lblas
SRC = $(SRC_DIR)/MathTools.f90\
      $(SRC_DIR)/Diagonalizacion.f90
OBJS = $(OBJ_DIR)/MathTools.o\
       $(OBJ_DIR)/Diagonalizacion.o

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.f90
	@mkdir -p $(OBJ_DIR)
	gfortran $(FLAGS1) -o $@ -c $<

$(TARGET): $(OBJS)
	@gfortran $(FLAGS1) -o $@ $(OBJS) $(FLAGS2)

move:
	@mkdir -p mod
	@mv *.mod mod

.PHONY: clean
clean:
	@rm -r $(OBJ_DIR) mod
	@rm -f $(TARGET)
