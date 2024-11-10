cmake_minimum_required(VERSION 3.13) 
project(345toMqtt)               
set(CMAKE_CXX_STANDARD 11)

# PkgConfig
find_package(PkgConfig REQUIRED)
# Mosquittopp
pkg_check_modules(Mosquitto IMPORTED_TARGET libmosquittopp REQUIRED)
# RTL-SDR
pkg_check_modules(RTL-SDR IMPORTED_TARGET librtlsdr REQUIRED)
# YAML-CPP
find_package(yaml-cpp REQUIRED)

add_executable(${PROJECT_NAME} 
	src/main.cpp
	src/analogDecoder.cpp
	src/analogDecoder.h
	src/digitalDecoder.cpp
	src/digitalDecoder.h
	src/mqtt.cpp
	src/mqtt.h
	src/mqtt_values.h
	)

target_link_libraries(${PROJECT_NAME} PkgConfig::Mosquitto PkgConfig::RTL-SDR yaml-cpp::yaml-cpp)