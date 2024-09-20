.SUFFIXES:
.SUFFIXES: .o .f90 .exe

FOX_CONFIG=$(HOME)/FoX/FoX-config
TARGET=`basename \`pwd\``.exe

FC=g95

default:
	$(MAKE) $(TARGET)

.f90.exe:
	$(FC) `$(FOX_CONFIG) --fcflags` -o $@ $< `$(FOX_CONFIG) --libs`

clean:
	rm *.exe
