#bin/bash

function usage () {
	echo "Usage $0 build | clean | run | show | [ -h | --help ]"
	echo -e "\t build : build unit test "
	echo -e "\t clean : clean unit test "
	echo -e "\t run : run test and Generate code coverage information"
	echo -e "\t show : show code coverage information at web"
	echo -e "\t -h,--help : help info "

}
function testclean () {
	rm -rf build 
	rm -rf htdocs
}
function testbuild () {
	testclean
	mkdir build 
	cd build 
	echo  "Build Makefile"
	cmake ../src &>/dev/null
	if [ $? -ne 0 ]
		then 
			cmake ../src
			exit -1
	else
		echo "Build Makefile successful!"
	fi
	make  
	if [ $? -ne 0 ]
	then 
	exit -1
	fi
	cd ..
}
function testrun() {
	if [ ! -d ./build ]
	then 
		testbuild
	fi
	echo "start initialize lcov coverage"
	lcov -d build -z &>/dev/null
	if [ $? -ne 0 ]
	then 
		lcov -d build -z
		exit -1
	fi
	lcov --rc lcov_branch_coverage=1 -d build -b . --no-external --initial -c -o build/CMakeGcovSupportInitialCoverage.info &>/dev/null
	if [ $? -ne 0 ]
	then 
		lcov --rc lcov_branch_coverage=1 -d build -b . --no-external --initial -c -o build/CMakeGcovSupportInitialCoverage.info
		exit -1
	else
		echo "initialize lcov coverage successful!"
	fi

	cd build

	make test
	if [ $? -ne 0 ]
	then 
		rm -rf CMakeGcovSupportInitialCoverage.info
		exit -1
	fi

	cd ..

	echo "start report lcov coverage"
	lcov --rc lcov_branch_coverage=1 -d build -b . --no-external -c -o build/CMakeGcovSupportCoverage.info &>/dev/null
	if [ $? -ne 0 ]
	then 
		lcov --rc lcov_branch_coverage=1 -d build -b . --no-external -c -o build/CMakeGcovSupportCoverage.info
		exit -1
	fi
	genhtml -o htdocs --prefix=`pwd` build/CMakeGcovSupportInitialCoverage.info build/CMakeGcovSupportCoverage.info &>/dev/null
	if [ $? -ne 0 ]
	then 
		genhtml -o htdocs --prefix=`pwd` build/CMakeGcovSupportInitialCoverage.info build/CMakeGcovSupportCoverage.info 
		exit -1
	else
		echo "report lcov coverage successful!"
	fi
}
function testshow () {
	if [ ! -d ./htdocs ]
	then 
		testrun
	fi
	echo "Start http server!"
	./start
}


while true
do
	case "$1" in
	clean ) testclean ; break;;
	build ) testbuild ; break;;
	run ) testrun ; break ;;
	show ) testshow ; break ;;
	-h | --help ) usage; exit 0;;
	* ) echo "Internal error !" ; usage ; exit 1;;
	esac
done


