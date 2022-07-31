input=prcData(:,1:end-1);
TargetOutputs=prcData(:,end);
[net,performance,e]=TrainNeualNet(input,TargetOutputs);


mat=net(input');
mat(mat>.6)=1;
mat(mat<=.6)=0;

indices = crossvalind('Kfold',Feat(:,end),5);
cp = classperf(Feat(:,end));
for i = 1:10
    test = (indices == i); train = ~test;
    %     Mdl = fitctree(Featn(train,1:end-1),Feat(train,end));
    input=prcData(train,1:end-1);
    TargetOutputs=prcData(train,end);
    [net,performance,e]=TrainNeualNet(input,TargetOutputs);
    
    %     class = predict(Mdl,Featn(test,1:end-1));
    class=net(prcData(test,1:end-1)');
    %     class = classify(Feat(test,1:end-1),Feat(train,1:end-1),Feat(train,end));
    classperf(cp,class,test);
end
finasl_errorRate=cp.ErrorRate;