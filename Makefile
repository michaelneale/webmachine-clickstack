#
# Crude, but effective

build_dir = ./build


package: clean
	mkdir -p build
	chmod 755 setup
	zip $(build_dir)/webmachine-clickstack.zip setup patch_webmachine.erl
	echo "Now upload $(build_dir)/webmachine-clickstack.zip"

clean:
	rm -rf $(build_dir)	

