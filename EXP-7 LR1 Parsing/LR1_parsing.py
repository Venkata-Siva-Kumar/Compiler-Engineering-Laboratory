from collections import defaultdict

# Augmented Grammar
grammar = {
    "S'": ["S"],     # Augmented start
    "S": ["A B"],
    "A": ["a"],
    "B": ["b"]
}

terminals = ['a', 'b', '$']
non_terminals = list(grammar.keys())


first = {
    "S'": ['a'],
    "S": ['a'],
    "A": ['a'],
    "B": ['b']
}


def first_of_string(symbols):
    result = set()
    for sym in symbols:
        if sym in terminals:
            result.add(sym)
            return result
        result |= set(first[sym]) - {'@'}
        if '@' not in first[sym]:
            return result
    result.add('@')
    return result


def closure(items):
    closure_set = set(items)
    added = True
    while added:
        added = False
        new_items = set()
        for head, body, dot, lookahead in closure_set:
            if dot < len(body):
                B = body[dot]
                if B in grammar:
                    beta = list(body[dot + 1:]) + [lookahead]
                    lookaheads = first_of_string(beta)
                    for prod in grammar[B]:
                        prod_body = tuple(prod.split())
                        for l in lookaheads:
                            new_item = (B, prod_body, 0, l)
                            if new_item not in closure_set:
                                new_items.add(new_item)
        if new_items:
            closure_set |= new_items
            added = True
    return closure_set


def goto(items, symbol):
    moved = {(h, b, d+1, l) for h, b, d, l in items if d < len(b) and b[d] == symbol}
    return closure(moved)



def canonical_collection():
    start = closure({("S'", tuple(grammar["S'"][0].split()), 0, '$')})
    C = [start]
    transitions = {}
    queue = [start]
    while queue:
        I = queue.pop(0)
        for X in terminals + non_terminals:
            goto_I = goto(I, X)
            if goto_I and goto_I not in C:
                C.append(goto_I)
                queue.append(goto_I)
            if goto_I:
                transitions[(C.index(I), X)] = C.index(goto_I)
    return C, transitions

# Build parsing table
def build_table(states, transitions):
    ACTION = defaultdict(dict)
    GOTO = defaultdict(dict)

    for i, state in enumerate(states):
        for head, body, dot, lookahead in state:
            if dot < len(body):
                a = body[dot]
                if a in terminals:
                    ACTION[i][a] = ("shift", transitions[(i, a)])
                elif a in non_terminals:
                    GOTO[i][a] = transitions[(i, a)]
            else:
                if head == "G'" and lookahead == "$":
                    ACTION[i]['$'] = ("accept",)
                else:
                    production = f"{head} -> {' '.join(body)}"
                    ACTION[i][lookahead] = ("reduce", production)
    return ACTION, GOTO

# Run
states, transitions = canonical_collection()
ACTION, GOTO = build_table(states, transitions)

# Output
print("\nLR(1) Parsing Table")
print("-------------------")
for i in sorted(ACTION.keys()):
    for symbol in ACTION[i]:
        print(f"ACTION[{i}][{symbol}] = {ACTION[i][symbol]}")
for i in sorted(GOTO.keys()):
    for symbol in GOTO[i]:
        print(f"GOTO[{i}][{symbol}] = {GOTO[i][symbol]}")
