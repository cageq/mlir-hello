

echo $1 

llfile=$1

#len=`expr ${#llfile} - 3`
#fileName=${llfile:0:$len}
#echo $fileName

fileName=${llfile%%\.ll}
echo $fileName
bcFile=${fileName}.bc
llvm-as  $llfile $bcFile
clang $bcFile -o $fileName


#llvm-as hello.ll hello.bc
#clang hello.bc  -o hello
#
#
#clang hello.bc  -o hello
