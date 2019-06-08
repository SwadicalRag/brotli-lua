mkdir -p buildfiles
cd buildfiles
cmake -DCMAKE_TOOLCHAIN_FILE=../wasi-toolchain.cmake ..
make