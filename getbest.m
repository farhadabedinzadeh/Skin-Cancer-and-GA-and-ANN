function [hiddenlayer,acc,vecLayer,indBest]=getbest(inp,target,maxlayer,maxnouronperlayer)




vecLayer=cell(1,20000);

cnt=0;

if maxlayer>=1
    for i=1:maxnouronperlayer
        cnt=cnt+1;
        vecLayer{cnt}=i;
    end
end


if maxlayer>=2
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            cnt=cnt+1;
            vecLayer{cnt}=[i i1];
        end
    end
end


if maxlayer>=3
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            for i2=1:maxnouronperlayer
                cnt=cnt+1;
                vecLayer{cnt}=[i i1 i2];
            end
        end
    end
end


if maxlayer>=4
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            for i2=1:maxnouronperlayer
                for i3=1:maxnouronperlayer
                    cnt=cnt+1;
                    vecLayer{cnt}=[i i1 i2 i3];
                end
            end
        end
    end
end


if maxlayer>=5
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            for i2=1:maxnouronperlayer
                for i3=1:maxnouronperlayer
                    for i4=1:maxnouronperlayer
                        cnt=cnt+1;
                        vecLayer{cnt}=[i i1 i2 i3 i4];
                        
                    end
                end
            end
        end
    end
end


if maxlayer>=6
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            for i2=1:maxnouronperlayer
                for i3=1:maxnouronperlayer
                    for i4=1:maxnouronperlayer
                        for i5=1:maxnouronperlayer
                            cnt=cnt+1;
                            vecLayer{cnt}=[i i1 i2 i3 i4 i5];
                            
                        end
                    end
                end
            end
        end
    end
end


if maxlayer>=7
    
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            for i2=1:maxnouronperlayer
                for i3=1:maxnouronperlayer
                    for i4=1:maxnouronperlayer
                        for i5=1:maxnouronperlayer
                            for i6=1:maxnouronperlayer
                                cnt=cnt+1;
                                vecLayer{cnt}=[i i1 i2 i3 i4 i5 i6];
                            end
                        end
                    end
                end
                
            end
        end
    end
end


if maxlayer>=8
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            for i2=1:maxnouronperlayer
                for i3=1:maxnouronperlayer
                    for i4=1:maxnouronperlayer
                        for i5=1:maxnouronperlayer
                            for i6=1:maxnouronperlayer
                                for i7=1:maxnouronperlayer
                                    cnt=cnt+1;
                                    vecLayer{cnt}=[i i1 i2 i3 i4 i5 i6 i7];
                                    
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


if maxlayer>=9
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            for i2=1:maxnouronperlayer
                for i3=1:maxnouronperlayer
                    for i4=1:maxnouronperlayer
                        for i5=1:maxnouronperlayer
                            for i6=1:maxnouronperlayer
                                for i7=1:maxnouronperlayer
                                    for i8=1:maxnouronperlayer
                                        
                                        cnt=cnt+1;
                                        vecLayer{cnt}=[i i1 i2 i3 i4 i5 i6 i7 i8];
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


if maxlayer>=10
    for i=1:maxnouronperlayer
        for i1=1:maxnouronperlayer
            for i2=1:maxnouronperlayer
                for i3=1:maxnouronperlayer
                    for i4=1:maxnouronperlayer
                        for i5=1:maxnouronperlayer
                            for i6=1:maxnouronperlayer
                                for i7=1:maxnouronperlayer
                                    for i8=1:maxnouronperlayer
                                        for i9=1:maxnouronperlayer
                                            cnt=cnt+1;
                                            vecLayer{cnt}=[i i1 i2 i3 i4 i5 i6 i7 i8 i9];
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


kin=randperm(size(inp,1),round(.9*size(inp,1)));
kin=kin';
kout=[];
for i=1:size(inp,1)
    if isempty(find(kin==i))
        kout=[kout; i];
    end
end

acc=zeros(cnt,1);
for i=1:cnt
    hiddenLayer=vecLayer{i};
    %     [net,performance,e]=TrainNeualNet(inp(kin),target(kin),hiddenLayer);
    [net,performance,e]=TrainNeualNet(inp,target,hiddenLayer);
    output=net(inp');
    output=round(output);
    acc(i)=sum(abs((output'-target)));
end


indBest=find(acc==min(acc));
hiddenlayer=vecLayer{indBest(1)};


