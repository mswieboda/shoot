SHELL = /bin/sh
CC = crystal build
BUILD_DIR = build
OUT_FILE = ${BUILD_DIR}/shoot
SOURCE_FILES = src/shoot.cr

build_and_test: clean test

clean:
ifneq ($(OS),Windows_NT)
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
