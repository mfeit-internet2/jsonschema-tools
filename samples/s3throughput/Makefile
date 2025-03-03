#
# Makefile for experimenting with jsonschema-tools
#

DICTS := \
	pscheduler-dictionary

BIN := ../..

default: build

SINGLE := single
VALIDATOR := validator
EXTRACT_LATEST := $(BIN)/extract-latest
$(SINGLE): $(EXTRACT_LATEST) $(VALIDATOR)
	$(EXTRACT_LATEST) < $(VALIDATOR) > $@


MERGED := merged
MERGE := $(BIN)/jsonschema-merge-dicts
$(MERGED): $(MERGE) $(SINGLE) $(DICTS)
	$(MERGE) --pretty $(SINGLE) $(DICTS) > $@
TO_CLEAN += $(MERGED)


DEREFED := deref
DEREF := $(BIN)/jsonschema-deref
$(DEREFED): $(DEREF) $(MERGED)
	$(DEREF) --pretty --overlay $(MERGED) > $@
TO_CLEAN += $(DEREFED)

ENUM := enumeration
FULL := full
$(FULL): $(ENUM) $(DEREFED)
	jq --slurp '.[0].validator = .[1] | .[0]' $(ENUM) $(DEREFED)
TO_CLEAN += $(FULL)


build: $(DEREFED)


# Detritus from running the programs
TO_CLEAN += __pycache__


clean:
	rm -rf $(TO_CLEAN) *~
