from collections import defaultdict

# Your grammar and FIRST/FOLLOW sets
g = {
    'G': ['E'],
    'E': ['TZ'],
    'Z': ['+TZ', '-TZ', '@'],
    'T': ['FY'],
    'Y': ['*FY', '/FY', '@'],
    'F': ['(E)', 'i', 'n']
}

first = {
    'Z': ['+', '-', '@'],
    'T': ['(', 'i', 'n'],
    'E': ['(', 'i', 'n'],
    'F': ['(', 'i', 'n'],
    'Y': ['*', '/', '@'],
    'G': ['(', 'i', 'n']
}

follow = {
    'G': ['$', ')'],
    'E': ['$', ')'],
    'Z': ['$', ')'],
    'T': ['+', '-', '$', ')'],
    'Y': ['+', '-', '$', ')'],
    'F': ['*', '/', '+', '-', '$', ')']
}


table = defaultdict(dict)

for non_terminal in g:
    for production in g[non_terminal]:
        if production == '@':  
            for f in follow[non_terminal]:
                table[non_terminal][f] = '@'
        else:
            first_chars = []
            for symbol in production:
                if symbol in first:
                    first_chars += first[symbol]
                    if '@' not in first[symbol]:
                        break
                else:
                    first_chars.append(symbol)
                    break
            for terminal in set(first_chars) - {'@'}:
                table[non_terminal][terminal] = production
            if '@' in first_chars:
                for f in follow[non_terminal]:
                    table[non_terminal][f] = '@'

# Print the LL(1) Parsing Table
print("LL(1) Parsing Table:")
for nt in table:
    for t in table[nt]:
        print(f"T[{nt}][{t}] = {nt} -> {table[nt][t]}",end="\t")
    print()
