#!/bin/bash

set -e

#git subtree pull --squash --prefix thirdparty/llvm-project git@github.com:llvm/llvm-project.git main
#git subtree pull --squash --prefix thirdparty/llvm-project https://github.com/llvm/llvm-project.git  main
#git subtree pull --squash --prefix thirdparty/llvm-project https://gitee.com/mirrors/llvm-project.git  main

mkdir -p  $PWD/thirdparty/llvm-project/build
pushd $PWD/thirdparty/llvm-project/build
cmake -G Ninja ../llvm \
   -DLLVM_ENABLE_PROJECTS=mlir \
   -DLLVM_BUILD_EXAMPLES=ON \
   -DLLVM_TARGETS_TO_BUILD="host" \
   -DCMAKE_BUILD_TYPE=Release \
   -DLLVM_ENABLE_ASSERTIONS=ON -Wno-dev
cmake --build . --target check-mlir

popd

mkdir -p $PWD/build
pushd $PWD/build

cmake -G Ninja .. \
    -DLLVM_DIR=$PWD/../thirdparty/llvm-project/build/lib/cmake/llvm \
    -DMLIR_DIR=$PWD/../thirdparty/llvm-project/build/lib/cmake/mlir \
    -Wno-dev

cmake --build . --target check-hello
