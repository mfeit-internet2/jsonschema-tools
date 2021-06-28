#
# Makefile for experimenting with jsonschema-tools
#

SCHEMA=idle-schema

MERGED=$(SCHEMA)-merged
DEREFED=$(SCHEMA)-deref

default: $(SCHEMA)-deref

$(MERGED): jsonschema-merge-dicts $(SCHEMA) pscheduler-dictionary
	./jsonschema-merge-dicts --pretty $(SCHEMA) pscheduler-dictionary > $@
TO_CLEAN += $(MERGED)

$(DEREFED): $(MERGED)
	./jsonschema-deref --pretty --overlay $< > $@
TO_CLEAN += $(DEREFED)

# Detritus from running the programs
TO_CLEAN += __pycache__

clean:
	rm -rf $(TO_CLEAN) *~
