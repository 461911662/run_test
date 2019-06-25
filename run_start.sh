#! /bin/bash
NAME="laplat_camera"
PWD=`pwd`
src_dir=".tar_project"
var=""

function Usage
{
        echo -e "\n${NAME}: version 0.1"
	echo "Options:"
	echo -e "\tclean: clean the project cache."
	echo -e "\tinstall: install exec bins,depond libs and include files etc."
	echo -e "\tuninstall: remove this project from the system.\n"
}

#_start
if [ -z $1 ];then
	Usage
	exit 0
fi

if [ $1 != "install" ] && [ $1 != "uninstall" ] && [ $1 != "clean" ];then
	Usage
	exit 0
fi

#create workspace
mkdir -p $PWD/$src_dir/out
mkdir -p $PWD/$src_dir/source
mkdir -p $PWD/$src_dir/source/bin
mkdir -p $PWD/$src_dir/source/build
mkdir -p $PWD/$src_dir/source/include
mkdir -p $PWD/$src_dir/source/lib

lines=76
tail -n +$lines $0 >/tmp/src.tar.gz
if [ -d $PWD/$src_dir/source/src ];then
	rm -rf $PWD/$src_dir/source/src
fi
tar -zxf /tmp/src.tar.gz -C $PWD/$src_dir/source/
rm -rf /tmp/src.tar.gz

#genrate scripts
if [ -f $PWD/$src_dir/source/src/build.py ] && [ -f $PWD/$src_dir/source/src/start.sh ];then
	[ -f $PWD/$src_dir/source/bin/build.py ] && rm -rf $PWD/$src_dir/source/bin/build.py
	mv $PWD/$src_dir/source/src/build.py $PWD/$src_dir/source/bin/
	[ -f $PWD/$src_dir/start.sh ] && rm -rf $PWD/$src_dir/start.sh
	mv $PWD/$src_dir/source/src/start.sh $PWD/$src_dir/
	chmod a+x $PWD/$src_dir/source/bin/build.py
	chmod a+x $PWD/$src_dir/start.sh
else
	var="clean"
fi

cd $PWD/$src_dir/

if [ $1 == "install" ];then
	./start.sh make
	./start.sh install
fi

if [ $1 == "uninstall" ];then
	./start.sh make
	./start.sh uninstall
fi

cd ../
PWD=`pwd`

if [ $1 == "clean" ] || [ "s"$var == "sclean" ];then
	#echo "${PWD}/${src_dir}"
	rm -rf "${PWD}/${src_dir}"
fi
exit 0

