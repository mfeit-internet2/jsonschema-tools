#
# Makefile for experimenting with jsonschema-tools
#

SCHEMA=s3throughput-schema

SINGLE=$(SCHEMA)-single
MERGED=$(SCHEMA)-merged
DEREFED=$(SCHEMA)-deref

DICTS=\
	pscheduler-dictionary


default: $(SCHEMA)-deref

$(SINGLE): extract-latest $(SCHEMA)
	./extract-latest < $(SCHEMA) > $@

$(MERGED): jsonschema-merge-dicts $(SINGLE) $(DICTS)
	./jsonschema-merge-dicts --pretty $(SINGLE) $(DICTS) > $@
TO_CLEAN += $(MERGED)

$(DEREFED): $(MERGED)
	./jsonschema-deref --pretty --overlay $< > $@
TO_CLEAN += $(DEREFED)

# Detritus from running the programs
TO_CLEAN += __pycache__

clean:
	rm -rf $(TO_CLEAN) *~
