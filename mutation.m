function  mutpop=mutation(mutpop,pop,nvar,nmut)
global popsize

for n=1:nmut
    
    i=randi([1 popsize]);
    
    p=pop(i).var;
    
    j1=randi([1 nvar-1]);
    j2=randi([j1+1 nvar]);
    
    nj1=p(j1);
    nj2=p(j2);
    
    
    p(j1)=nj2;
    p(j2)=nj1;
    
    mutpop(n).var=p;
    [f1,f2]=Cost(p);
    mutpop(n).fit=[f1 f2 f1+f2];
    
end

