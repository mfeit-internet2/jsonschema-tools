# jsonschema-tools

This is a pair of programs that 

`jsonschema-merge-dicts` takes one or more JSON Schema files and makes them one.

`jsconschema-deref` finds `$ref` tags anywhere in the schema, replaces
them with the types to which they refer and then removes anything
outside the root that is unreferenced.


Run either program with the `--help` switch for invocation and
options.
