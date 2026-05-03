def local_list_scheduling(operations,delay,edges):
    predecessor = { op : [] for op in operations }
    for u,v in edges:
        predecessor[v].append(u)
    
    cycle = 1
    ready = [op for op in operations if len(predecessor[op]) == 0]
    active = []
    
    start = {}
    finish = {}
    
    print("{:^15}|{:^25}|{:^25}".format("Cycle","Ready","Active"))
    print('-'*65)
    while ready or active:
        print("{:^15}|{:^25}|{:^25}".format(cycle,str(ready),str(active)))
        if ready:
            op = ready.pop(0)
            start[op] = cycle
            finish[op] = cycle + delay[op]
            active.append(op)
        cycle += 1
        
        for op in active[:]:
            if finish[op] <= cycle:
                active.remove(op)
                
                for u,v in edges:
                    if u == op:
                        if all(p in start for p in predecessor[v]):
                            if v not in ready and v not in active:
                                ready.append(v)
    
    sorted_ops = sorted(operations, key=lambda op: start[op])
    print("\n{:^15}|{:^15}|{:^15}".format("Operation", "Start", "Finish"))
    print("-" * 47)  
    for op in sorted_ops:
        print("{:^15}|{:^15}|{:^15}".format(op,start[op],finish[op]))


operations = ['a','b','c','d','e','f','g','h','i']
delay = { 'a':3, 'b':1, 'c':3, 'd':2,'e':3, 'f':2, 'g':3, 'h':2, 'i':3 }

edges = [
    ('a','b'),
    ('b','d'),
    ('c','d'),
    ('d','f'),
    ('e','f'),
    ('f','h'),
    ('g','h'),
    ('h','i')
]

local_list_scheduling(operations,delay,edges)