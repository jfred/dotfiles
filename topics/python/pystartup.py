from dis import dis
from pprint import pprint
__builtins__.dis = dis
__builtins__.pprint = pprint
del dis, pprint

try:
    import readline
except ImportError:
    print("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
