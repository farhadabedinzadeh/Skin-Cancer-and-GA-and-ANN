
%% parameters setting

% load('database.mat')

global Feat popsize
% Feat=data;


nvar=size(Feat,2)-1;
popsize=100;
maxiter=100;

pc=0.9;
ncross=2*round((popsize*pc)/2);

pm=1-pc;
nmut=round(popsize*pm);



%% initial population algorithm
tic

emp.var=[];
emp.fit=[];

pop=repmat(emp,popsize,1);


for i=1:popsize
    
    pop(i).var=randi([0,1],1,nvar);
    [f1,f2]=Cost(pop(i).var);
    pop(i).fit=[f1 f2 f1+f2];
    
end

% [value,index]=max([pop.fit]);
% gpop=pop(index);
[pop,val_ovrcm]=sort_sample(pop);






%% main loop algorithm

BEST=zeros(maxiter,1);

for iter=1:maxiter
    
    % crossover
    crosspop=repmat(emp,ncross,1);
    crosspop=crossover(crosspop,pop,nvar,ncross);
    
    
    % mutation
    mutpop=repmat(emp,nmut,1);
    mutpop=mutation(mutpop,pop,nvar,nmut);
    
    
    [pop]=[pop;crosspop;mutpop];
    
    %     [value,index]=sort([pop.fit],'descend');
    %     pop=pop(index);
    %     gpop=pop(1);
    [pop,val_ovrcm]=sort_sample(pop);
    %     pop=pop(1:popsize);
    gpop=pop(1);
    vc=gpop.fit;
    gpop.var
    
%     BEST(iter)=
    disp([' Iter = ' num2str(iter) ' BEST>ovrcm  ' num2str(val_ovrcm(1)) ' BEST>f1,f2  ' num2str(vc(1:2))])
%     disp([' Iter = ' num2str(iter)  ' BEST = ' num2str(BEST(iter))])
    
    
    
    
end


%% results algorithm
% BEST=BEST(1:iter);

disp([ ' Best Solution = '  num2str(gpop.var)])
disp([ ' Best Fitness = '  num2str(gpop.fit)])
disp([ ' Time = '  num2str(toc)])

%%%%%%%%%


x=gpop.var;
[r,c]=find(x==1);
prcData=Feat(:,c);
prcData=[prcData Feat(:,end)];











