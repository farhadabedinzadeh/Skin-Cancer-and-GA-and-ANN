function  crosspop=crossover(crosspop,pop,nvar,ncross)
global popsize
% f=[pop.fit];
% f=f(3:3:end);
% f=max(f)-f+eps;
% f=f./sum(f);
% f=cumsum(f);


for n=1:2:ncross
    
%     i1=find(rand<=f,1,'first');
%     i2=find(rand<=f,1,'first');
    
   index=randperm(popsize,2);

    p1=pop(index(1)).var;
    p2=pop(index(2)).var;
    
    j=randi([1 nvar-1]);
    
    
    o1=[p1(1:j) p2(j+1:end)];
    o2=[p2(1:j) p1(j+1:end)];
    
    
    crosspop(n).var=o1;
    [f1,f2]=Cost(o1);
    crosspop(n).fit=[f1 f2 f1+f2];
    
    %     crosspop(n).fit=fitness(o1,acc,target);
    
    crosspop(n+1).var=o2;
    [f1,f2]=Cost(o2);
    crosspop(n+1).fit=[f1 f2 f1+f2];
    %     crosspop(n+1).fit=fitness(o2,acc,target);
end





















