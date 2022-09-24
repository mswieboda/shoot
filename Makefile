SHELL = /bin/sh
CC = crystal build
BUILD_DIR = build
OUT_FILE = ${BUILD_DIR}/shoot
SOURCE_FILES = src/shoot.cr
SFML_DLL_DIR = D:\\Program Files\\SFML-2.5.1\\bin

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
	rename ${BUILD_DIR} shoot
	7z a -tzip -mx9 shoot\\shoot.zip shoot\\*
	rename shoot ${BUILD_DIR}
endif
