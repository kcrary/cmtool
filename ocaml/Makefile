
MODULES=FStream LexEngine LexInfo ListUtil ParseEngine Streamable StringUtil

INTERFACES= $(foreach mod, $(MODULES), $(mod).cmi)
BINARIES= $(foreach mod, $(MODULES), $(mod).cmo) 

all: $(INTERFACES) $(BINARIES) util.a

%.cmi : %.mli
	ocamlc -c $<

%.cmo : %.ml
	ocamlc -c $<

util.a : $(BINARIES)
	ocamlc -a -o util.a $(BINARIES)

clean:
	rm *.cmi *.cmo util.a
