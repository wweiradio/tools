#!/bin/bash 

#!/bin/sh

test_path="$PWD"/test 
run_path="$PWD"/run 
echo $test_path 
echo $run_path 

exefile="${1}"

[[ -n ${exefile} ]] || { echo "错误，请提供可执行文件名，例如 runtest.sh exefile.另外，确保官方文件在test目录中，生成的文件在run中 "; exit; }

[[  -d "test" ]] || { echo "没有test文件夹，先创建test文件夹，把测试用例.in .out文件放好" ; exit; }

[[  -d "run" ]] || { mkdir -p run; }

for dir in `ls $test_path/*.in`
do
    casefile=`(basename -- $dir)`
    echo 
    echo $casefile 
    casefile_only="${casefile%.in}" 
    cmd="./${exefile} < ${test_path}/${casefile} > ${run_path}/${casefile_only}.out && diff -B --side-by-side --suppress-common-lines ${test_path}/${casefile_only}.out  ${run_path}/${casefile_only}.out "
    eval "${cmd}"
done