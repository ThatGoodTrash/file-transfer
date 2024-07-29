# Makefile for the file transfer program

# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
LDFLAGS = -static

LIB_PATHS = /usr/local/lib /usr/lib
LIBS = -lzip -lssh -lssl -lcrypto -lz -lzstd -lgssapi

# Output binary name
TARGET = file-transfer

# Source files
SRCS = file-transfer.cpp

# Object files
OBJS = $(SRCS:.cpp=.o)

# Build target
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $(OBJS) $(LIBS) $(LDFLAGS) -o $(TARGET)  

# Clean up
clean:
	rm -f $(TARGET) $(OBJS)

# Compile each .cpp file to .o file
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY: all clean
