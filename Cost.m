function [f1,f2]=Cost(x)
global Feat

if sum(x)>1
ind=find(x==1);
Featn=Feat(:,ind);


indices = crossvalind('Kfold',Feat(:,end),10);
cp = classperf(Feat(:,end));
for i = 1:10
    test = (indices == i); train = ~test;
    Mdl = fitctree(Featn(train,1:end-1),Feat(train,end));
    class = predict(Mdl,Featn(test,1:end-1));
    %     class = classify(Feat(test,1:end-1),Feat(train,1:end-1),Feat(train,end));
    classperf(cp,class,test);
end
f1=cp.ErrorRate;


indices = crossvalind('Kfold',Feat(:,end),10);
cp = classperf(Feat(:,end));
for i = 1:10
    test = (indices == i); train = ~test;
    class = classify(Feat(test,1:end-1),Feat(train,1:end-1),Feat(train,end));
    classperf(cp,class,test);
end
f2=cp.ErrorRate;
else
    f1=inf;
    f2=inf;
end
