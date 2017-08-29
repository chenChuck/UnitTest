#/bin/bash

rm test.info test1.info &>/dev/null 

lcov -d . -z &>/dev/null 



function usage () 
{
	echo "Usage $0 test src name and test name "
	echo -e "\tLike $0 test.cc unittest_test"
}


if [ "" = "$1" ]
then
	usage
	exit 1
fi
if [ "" = "$2" ]
then
	usage
	exit 1
fi




DATA_NAME=`find . -name $1.gcno`
SRC_DIR=`find . -name $1 | awk -F "/$1" '{print $1}' | awk -F '/' '{print $2}'`
RUN=`find . -name $2`



echo "Start the first data collection!"

lcov --rc lcov_branch_coverage=1 -d ${DATA_NAME}  -b ${SRC_DIR} --no-external --initial -c -o test.info &>/dev/null 
if [ $? -eq 0 ]
then 
	echo "The first data collection OK!"
else
	lcov --rc lcov_branch_coverage=1 -d ${DATA_NAME}  -b ${SRC_DIR} --no-external --initial -c -o test.info
	echo "The first data collection error"
	exit 1
fi
echo ""
echo "Run the test!"
${RUN}
echo "test ok!"

RUN_DATA_NAME=`find . -name $1.gcda` 
echo ""
echo "Start the second data collection!"
lcov --rc lcov_branch_coverage=1 -d ${RUN_DATA_NAME}  -b ${SRC_DIR} --no-external  -c -o test1.info &>/dev/null 
if [ $? -eq 0 ]
then 
	echo "The second data collection OK!"
else
	lcov --rc lcov_branch_coverage=1 -d ${RUN_DATA_NAME}  -b ${SRC_DIR} --no-external  -c -o test1.info
	echo "The second data collection error"
	exit 1
fi


genhtml -o htdocs --prefix=`pwd` test.info test1.info  &>/dev/null 
if [ $? -ne 0 ]
then 
	genhtml -o htdocs --prefix=`pwd` test.info test1.info
	rm -rf htdocs test.info test1.info &>/dev/null 
	exit 1
fi

rm test.info test1.info &>/dev/null 

./start 

