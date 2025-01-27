@echo on

REM Release tarballs do not contain the required Protobuf definitions.
robocopy /S /E %BUILD_PREFIX%\share\opentelemetry\opentelemetry-proto\opentelemetry .\third_party\opentelemetry-proto\opentelemetry >nul
REM Stop CMake from trying to git clone the Protobuf definitions.
mkdir .\third_party\opentelemetry-proto\.git

mkdir build-cpp
cd build-cpp

cmake -GNinja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_CXX_STANDARD=17 ^
    -DCMAKE_PREFIX_PATH=%CONDA_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_TESTING=OFF ^
    -DOPENTELEMETRY_INSTALL=ON ^
    -DWITH_ABSEIL=ON ^
    -DWITH_API_ONLY=OFF ^
    -DWITH_BENCHMARK=OFF ^
    -DWITH_ETW=ON ^
    -DWITH_EXAMPLES=OFF ^
    -DWITH_METRICS_PREVIEW=ON ^
    -DWITH_OTLP_GRPC=ON ^
    -DWITH_OTLP_HTTP=ON ^
    -DWITH_PROMETHEUS=ON ^
    -DWITH_ZIPKIN=ON ^
    ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build .
if %ERRORLEVEL% neq 0 exit 1
