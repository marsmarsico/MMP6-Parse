.PHONY: test

clean:
	@rm -rf lib/P6Parser/Verilog/.precomp

test:
	@clear
	@prove -e perl6 t/t*

