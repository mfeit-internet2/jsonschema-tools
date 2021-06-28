#
# Functions common to JSON Schema Utilities
#

import json
import sys

def die(message):
    """Print an error message and bail out."""
    print(message, file=sys.stderr)
    exit(1)



def dump_json(data, pretty=False):
    """Dump JSON, with optional prettification, to stdout"""
    print(
        json.dumps(data, sort_keys=True, indent=4, separators=(',', ': ')) if pretty
        else json.dumps(data)
    )



def get_ref(struct, ref, leaf=False):
    """
    Figure out if a reference (e.g., "#/foo/bar") exists within a
    given structure and return it.
    """

    if not isinstance(struct, dict):
        return None

    parts = ref_parts(ref)

    result = {}
    result_current = result
    
    struct_current = struct

    for part in parts:
        if part not in struct_current:
            return None
        result_current[part] = {}
        result_current = result_current[part]
        struct_current = struct_current[part]

    if leaf:
        return struct_current

    result_current.update(struct_current)

    return result


def ref_parts(ref):
    parts = ref.split("/")
    if parts[0] != "#" or len(parts) < 2:
        raise ValueError("Invalid refernce {0}".format(ref))
    return parts[1:]
