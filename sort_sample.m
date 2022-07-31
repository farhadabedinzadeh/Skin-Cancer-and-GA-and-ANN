function [pop,V]=sort_sample(pop)
global popsize 


val_ovrcm=zeros(1,size(pop,1));

for i=1:size(pop,1)
    val=0;
    costi=pop(i).fit;
    for j=1:size(pop,1)
        costj=pop(j).fit;
        if i~=j && costj(1)<costi(1) && costj(2)<costi(2)
            val=val+1;
        end
    end
    val_ovrcm(i)=val;
end

[V,loc]=sort(val_ovrcm);
pop=pop(loc);
num=1:-1/popsize:0;
pop=pop(1:popsize);

for i=1:popsize
    vec=pop(i).fit;
    vec(3)=num(i);
    pop(i).fit=vec;
end