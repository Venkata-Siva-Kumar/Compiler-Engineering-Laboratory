def FIRST(g):
   first={}
   for key in g:
     first[key]=[]
     for item in g[key]:
       if (item[0].isupper()==False):
        first[key].append(item[0])
   changed = True
   while changed:
     changed = False
     for key in g:
       for item in g[key]:
         if item[0].isupper():
           for l in first[item[0]]:
             if l not in first[key]:
               first[key].append(l)
               changed = True
   return first


def FOLLOW(g,first):
   follow={}
   for key in g:
     follow[key]=[]
   follow['G']='$'
   
   changed = True
   while changed:
     changed = False
     for key in g:
       for item in g[key]:
         for i in range(len(item)):
           if item[i].isupper():
             if i+1 < len(item):
               if not item[i+1].isupper():
                 if item[i+1] not in follow[item[i]]:
                   follow[item[i]].append(item[i+1])
                   changed = True
               else:
                 for l in first[item[i+1]]:
                   if l != '@' and l not in follow[item[i]]:
                     follow[item[i]].append(l)
                     changed = True
                 if '@' in first[item[i+1]]:
                   for l in follow[key]:
                     if l not in follow[item[i]]:
                       follow[item[i]].append(l)
                       changed = True
             else:
               for l in follow[key]:
                 if l not in follow[item[i]]:
                   follow[item[i]].append(l)
                   changed = True
   
 
   return {k: list(set(v)) for k,v in follow.items()}




g={'G':['E'],'E':['TZ'],'Z':['+TZ','-TZ','@'],'T':['FY'],'Y':['*FY','/FY','@'],'F':['(E)','i','n']}
first=FIRST(g)
follow=FOLLOW(g,first)
for l in follow:
     if '@' in follow[l]:
       follow[l].remove('@')
       
print("FIRST SET:\n")
for k,v in first.items():
    print(k,v)
    
print("\nFOLLOW SET:\n")
for k,v in follow.items():
    print(k,v)
