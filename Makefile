all: datadir

images: setcards.asy 
	./asy-gen.sh
	for i in $$(seq 0 80); do asy -f png -o gui/data/ "$$i.asy"; echo $$i; done
	touch image-stamp

tar: image-stamp
	tar -cf images.tar gui/data/*.png

clean:
	$(RM) *.png ?.asy ??.asy
