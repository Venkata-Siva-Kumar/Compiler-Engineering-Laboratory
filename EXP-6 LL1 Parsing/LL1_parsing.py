"""
S → aA
A → b

table = {
            ('S','a'): ['a','A'],
            ('A','b'): ['b']
        }
"""
table = {}

n = int(input("Enter number of table entries: "))
print("Enter entries as: NonTerminal Terminal Production(RHS only) ")

for _ in range(n):
    nt, t, prod = input().split()
    table[(nt, t)] = prod

inp = list(input("Enter a Input String : "))

stack = ['$', 'S']
i = 0
step = 1

print("{:<5}{:<25}{:<25}{}".format("Step","Stack","Input","Action"))

while stack:
    stack_str = ' '.join(stack)
    input_str = ' '.join(inp[i:])

    top = stack.pop()
    current = inp[i]

    if top == current:
        action = "Match " + current
        i += 1

    elif (top,current) in table:
        rule = table[(top,current)]

        if rule != ['@']:
            for s in reversed(rule):
                stack.append(s)
            action = top + " -> " + ' '.join(rule)
        else:
            action = top + " -> @"

    else:
        print("String Rejected")
        break

    print("{:<5}{:<25}{:<25}{}".format(step, stack_str, input_str, action))
    step += 1

if len(stack) == 0 and i == len(inp):
    print("\nString Accepted")