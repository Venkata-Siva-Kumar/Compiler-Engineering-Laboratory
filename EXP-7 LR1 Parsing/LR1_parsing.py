# Simple LR Parser with correct ending logic

action = {
    (0,'c'):'S3',(0,'d'):'S4',
    (1,'$'):'acc',
    (2,'c'):'S6',(2,'d'):'S7',
    (3,'c'):'S3',(3,'d'):'S4',
    (4,'c'):'R3',(4,'d'):'R3',
    (5,'$'):'R1',
    (6,'c'):'S6',(6,'d'):'S7',
    (7,'$'):'R3',
    (8,'c'):'R2',(8,'d'):'R2',
    (9,'$'):'R2'
}

goto = {
    (0,'S'):1,(0,'C'):2,
    (2,'C'):5,
    (3,'C'):8,
    (6,'C'):9
}

prod = {
    1:("S","CC"),
    2:("C","cC"),
    3:("C","d")
}

inp = input("Enter input string: ")

if inp[-1] != '$':
    print("String must end with $")
    exit()

stack=[0]
i=0
step=1

print("\n{:<5}{:<15}{:<10}{}".format("Step","Stack","Input","Action"))

while True:

    state = stack[-1]
    sym = inp[i]

    if (state,sym) not in action:
        print("\nString is INVALID")
        break

    act = action[(state,sym)]
    stack_str = "".join(map(str,stack))
    rem = inp[i:]

    # SHIFT
    if act[0]=='S':
        print("{:<5}{:<15}{:<10}Shift {}".format(step,stack_str,rem,act))
        stack.append(sym)
        stack.append(int(act[1:]))
        i+=1

    # REDUCE
    elif act[0]=='R':
        r=int(act[1:])
        A,B=prod[r]
        print("{:<5}{:<15}{:<10}Reduce {}->{}".format(step,stack_str,rem,A,B))

        for _ in range(2*len(B)):
            stack.pop()

        state=stack[-1]
        stack.append(A)
        stack.append(goto[(state,A)])

    # ACCEPT
    else:
        if i == len(inp)-1:   # ensure input fully consumed
            print("{:<5}{:<15}{:<10}Accept".format(step,stack_str,rem))
            print("\nString is VALID")
        else:
            print("\nString is INVALID")
        break

    step+=1