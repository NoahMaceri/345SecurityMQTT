cmake_minimum_required(VERSION 3.13) 
project(345toMqtt)               
set(CMAKE_CXX_STANDARD 11)

# Moquittopp
find_package(PkgConfig REQUIRED)
pkg_check_modules(Mosquitto IMPORTED_TARGET libmosquittopp REQUIRED)

add_executable(${PROJECT_NAME} 
	src/main.cpp
	src/analogDecoder.cpp
	src/analogDecoder.h
	src/digitalDecoder.cpp
	src/digitalDecoder.h
	src/mqtt.cpp
	src/mqtt.h
	src/mqtt_config.h
	)

target_link_libraries(${PROJECT_NAME} PkgConfig::Mosquitto)