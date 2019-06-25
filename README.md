# run_test
关于fingerprint依赖库的安装包
laplat_camera.run:安装包
run_start.sh:安装脚本
src.tar.gz:安装压缩包
## Usage
cat run_start.sh src.tar.gz > laplat_camera.run
laplat_camera.run:
plat_camera: version 0.1
Options:
	clean: clean the project cache.
	install: install exec bins,depond libs and include files etc.
	uninstall: remove this project from the system.
