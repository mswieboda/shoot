SHELL = /bin/sh
CC = crystal build
BUILD_DIR = build
OUT_FILE = ${BUILD_DIR}/shoot
SOURCE_FILES = src/shoot.cr
SFML_DLL_DIR = D:\\Program Files\\SFML-2.5.1\\bin
SFML_MAC_DIR = /Users/matt/code/libs/SFML-2.5.1-macos-clang

build_and_test: clean test

clean:
ifeq ($(OS),Windows_NT)
	echo "cleaning..."
	rmdir /S /Q build
	mkdir build
else
	if [ ! -d "./${BUILD_DIR}" ]; then mkdir "${BUILD_DIR}"; else env echo "cleaning..." && rm -r ${BUILD_DIR}; mkdir "${BUILD_DIR}"; fi
endif

build_test:
	${CC} ${SOURCE_FILES} -o ${OUT_FILE}_test.o --error-trace

test: build_test
	./${OUT_FILE}_test.o

${OUT_FILE}.o:
	${CC} ${SOURCE_FILES} -o ${OUT_FILE}.o --release --no-debug

release: clean ${OUT_FILE}.o
	./${OUT_FILE}.o

winpack: clean ${OUT_FILE}.o
ifeq ($(OS),Windows_NT)
	copy run.bat ${BUILD_DIR}
	copy "${SFML_DLL_DIR}\\*.dll" ${BUILD_DIR}
	xcopy /E assets ${BUILD_DIR}\\assets\\
	rename ${BUILD_DIR} shoot
	7z a -tzip -mx9 shoot\\shoot-win.zip shoot\\*
	rename shoot ${BUILD_DIR}
endif

macpack: clean ${OUT_FILE}.o
	mkdir ${BUILD_DIR}/sfml
	cp -r "${SFML_MAC_DIR}/lib" ${BUILD_DIR}/sfml
	cp -r "${SFML_MAC_DIR}/extlibs" ${BUILD_DIR}/sfml
	platypus --load-profile shoot.platypus build/shoot.app
	mkdir shoot
	cp -r build/shoot.app shoot/shoot.app
	7zz a -tzip -mx9 ${BUILD_DIR}/shoot-mac.zip shoot/shoot.app
	rm -rf shoot
