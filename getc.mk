LD=clang
CXX=clang++

LIBNAME=google-test
REQUIRED_LIBS=
INCLUDE_PATH=include/

SRC=src/gtest-all.cc

TEST_NAME=getc-test
TEST_SRC=main.cc


CXXFLAGS += -Wall -pedantic -Werror -std=c++14 -stdlib=libc++ -I./
LDFLAGS += -lc++

CXXFLAGS += -I$(INCLUDE_PATH)
LDFLAGS += $(REQUIRED_LIBS)


LIB=lib$(LIBNAME).a
OBJ=$(SRC:.cc=.o)
TEST_OBJ=$(TEST_SRC:.cc=.o)
CURPATH=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all: $(TEST_NAME) $(LIB)

$(LIB): $(OBJ)
	$(AR) rcs $@ $^

$(TEST_NAME): $(TEST_OBJ) $(LIB)
	$(LD) -o $@ $^ $(LDFLAGS)

ldflags:
	@echo -L"$(CURPATH)" -l$(LIBNAME) $(REQUIRED_LIBS)

cxxflags:
	@echo -I"$(CURPATH)$(INCLUDE_PATH)"

clean:
	rm -rf $(TEST_NAME) $(TEST_OBJ) $(OBJ) $(LIB)
