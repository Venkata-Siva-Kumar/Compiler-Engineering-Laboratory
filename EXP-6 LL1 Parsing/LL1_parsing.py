table = {
('E','num'): ['T',"E'"], ('E','('): ['T',"E'"],

("E'",'-'): ['-','T',"E'"], ("E'",')'): ['@'], ("E'",'$'): ['@'],

('T','num'): ['F',"T'"], ('T','('): ['F',"T'"],

("T'",'/'): ['/','F',"T'"], ("T'",'-'): ['@'], ("T'",')'): ['@'], ("T'",'$'): ['@'],

('F','num'): ['P',"F'"], ('F','('): ['P',"F'"],

("F'",'^'): ['^','F'], ("F'",'/'): ['@'], ("F'",'-'): ['@'], ("F'",')'): ['@'], ("F'",'$'): ['@'],

('P','num'): ['num'], ('P','('): ['(','E',')']
}

inp = input("Enter input: ").split()

stack = ['$', 'E']
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