from collections import defaultdict, deque

task_info = {
    'load1': (1, 'MEM'),
    'load2': (1, 'MEM'),
    'add1': (1, 'INT'),
    'add2': (1, 'INT'),
    'cmp': (1, 'INT'),
    'store1': (4, 'MEM'),
    'store2': (4, 'MEM'),
    'cbr': (1, 'INT'),
}

dependencies = {
    'load1': [],
    'load2': [],
    'add1': ['load1'],
    'add2': ['load2'],
    'cmp': ['add1', 'add2'],
    'store1': ['cmp'],
    'store2': ['cmp'],
    'cbr': ['store1', 'store2'],
}

resource_limits = {
    'INT': 2,
    'MEM': 1
}


def schedule_tasks(task_info, dependencies, resource_limits):
    in_degree = {task: len(dependencies[task]) for task in task_info}

    dependents = defaultdict(list)
    for task, deps in dependencies.items():
        for dep in deps:
            dependents[dep].append(task)

    ready = deque([task for task in task_info if in_degree[task] == 0])

    time = 0
    resource_usage = defaultdict(lambda: defaultdict(int))
    result = {}

    while ready:
        task = ready.popleft()
        duration, res_type = task_info[task]

        earliest_start = 0
        for before_task in dependencies[task]:
            earliest_start = max(earliest_start, result[before_task][1])

        while True:
            can_run = True
            for t in range(earliest_start, earliest_start + duration):
                if resource_usage[t][res_type] >= resource_limits[res_type]:
                    can_run = False
                    break
            if can_run:
                break
            earliest_start += 1

        for t in range(earliest_start, earliest_start + duration):
            resource_usage[t][res_type] += 1

        result[task] = (earliest_start, earliest_start + duration)

        for next_task in dependents[task]:
            in_degree[next_task] -= 1
            if in_degree[next_task] == 0:
                ready.append(next_task)

    return result


schedule = schedule_tasks(task_info, dependencies, resource_limits)

print("Scheduled Tasks with Resources:")
for task in sorted(schedule, key=lambda x: schedule[x][0]):
    start, end = schedule[task]
    print(f"{task}\t:\tstart= {start},\tend= {end}")
    
    
