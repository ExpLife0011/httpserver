# Makefile for httpserver
# (C) Ramsey Kant 2011-2012

CC := g++
SRCDIR := src
BINDIR := bin
BUILDDIR := build
TARGET := httpserver

# Debug Flags
DEBUGFLAGS := -g3 -O0 -Wall
RTCHECKS := -fmudflap -fstack-check -gnato

# Production Flags
PRODFLAGS := -Wall -O2

# OSX Flags
#CFLAGS := -std=c++11 -stdlib=libc++ -Iinclude/ $(DEBUGFLAGS)
#LINK := -stdlib=libc++ $(DEBUGFLAGS)

# Linux Flags
CFLAGS := -std=c++11 -Iinclude/ $(DEBUGFLAGS)
LINK := -lpthread $(DEBUGFLAGS) -lkqueue
 
 
SRCEXT := cpp
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))

$(TARGET): $(OBJECTS)
	@echo " Linking..."; $(CC) $(LINK) $^ -o $(BINDIR)/$(TARGET)
 
$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@echo " CC $<"; $(CC) $(CFLAGS) -c -o $@ $<
 
clean:
	@echo " Cleaning..."; rm -r $(BUILDDIR) $(BINDIR)/$(TARGET)*
 
.PHONY: clean
