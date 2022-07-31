clc
clear
close all
global Feat

%% Preprocessing and Feature Extraction
Feat=[];
folderpath{1,1}='complete_mednode_dataset\melanoma\';
folderpath{1,2}='complete_mednode_dataset\naevus\';
numOfimage=[69 100];
for f=1:2
    for i=1:numOfimage(f)
        i
        path=[folderpath{1,f},num2str(i),'.jpg'];% image path
        
        image=imread(path);%read image
        image=rgb2gray(image);% rgb 2 gray
        image=im2double(image);% double image
        
        
        filter=fspecial('gaussian',[7,7],3);
        image=imfilter(image,filter);% gaussian filter
        
        th1=0;%threshhold 1
        th2=.5;% threshhold 2
        
        th=(th1+th2)/2;
        delta=abs(th1-th);
        
        mask=zeros(size(image));% mask
        mask(abs(image-th)<delta)=1;% image threshholding
        
        se=strel('disk',5);
        mask=imopen(mask,se);% morpohology pre process
        
        %% Target Area
        [L,num]=bwlabel(mask);
        val_area=-10;
        
        for ind=1:num
            [x,y]=find(L==ind);
            if numel(x)>val_area
                val_area=numel(x);
                index=ind;
            end
        end
        
        %% Binary Image = Target Area
        mask1=zeros(size(mask));
        [x,y]=find(L==index);
        for ind=1:numel(x)
            mask1(x(ind),y(ind))=1;
        end
        mask1=bwconvhull(mask1);
        % Target Area
        image=image.*mask1;
        
        
        %     max_wdth=[];
        %     for Lw=100:-2:5
        %         for ind=1:numel(x)
        %             mat=mask1(x(ind)-Lw:x(ind)+Lw,y(ind)-Lw:y(ind)+Lw);
        %             if numel(find(mat==0)<5)
        %                 max_wdth=[max_wdth ;x(ind) y(ind) Lw ];
        %             end
        %         end
        %     end
        %
        
        
        s = regionprops(mask1,'BoundingBox');
        
        
        vec=s.BoundingBox;
        
        
        brk=1;
        c=5;
        while brk==1
            c=c+2;
            matw=mask1(round(vec(2)+c):round(vec(2)+vec(4)-c),round(vec(1)+c):round(vec(1)+vec(3)-c));
            if numel(find(matw==0)) < 10
                brk=2;
            end
        end
        
        mat=image(round(vec(2)+c):round(vec(2)+vec(4)-c),round(vec(1)+c):round(vec(1)+vec(3)-c));
        
        
        
        feature=get_feature(mat,mask1,c);
        Feat=[Feat ;feature f];
        save ("Feat.mat","Feat")
        
        
    end
end


%% LDA
load('Feat.mat')
[Y, W, lambda] = LDA(Feat(:,1:end-1), Feat(:,end));
%% Genetic Algorithm
Feat(:,1:end-1)=Y;
Feat(:,end)=Feat(:,end)-1;
Genetic;


% % prcData=Feat;
input=prcData(:,1:end-1);
TargetOutputs=prcData(:,end);
% input=Feat(:,1:end-1);
% TargetOutputs=Feat(:,end);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxlayer= 3;
maxnouronperlayer=10;

[hiddenlayer,acc,vecLayer,indBest]=getbest(input,TargetOutputs,maxlayer,maxnouronperlayer);
disp(['the best combination of hidden layer is : ' num2str(hiddenlayer)])
disp(['accuracy for best combination is : ' num2str(acc(indBest(1)))])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [net,performance,e]=TrainNeualNet(input,TargetOutputs,hiddenlayer);

% [net,performance,e]=TrainNeualNet(input,TargetOutputs);


% mat=net(input');
% mat=round(mat);
% % mat(mat>.6)=1;
% % mat(mat<=.6)=0;

%% in acc deghat daste bandie khoruji ra moshakhas mikone 
% acc=(1-sum(abs(TargetOutputs-mat'))/numel(mat))*100

% indices = crossvalind('Kfold',Feat(:,end),5);
% cp = classperf(Feat(:,end));
% for i = 1:10
%     test = (indices == i); train = ~test;
%     %     Mdl = fitctree(Featn(train,1:end-1),Feat(train,end));
%     input=prcData(train,1:end-1);
%     TargetOutputs=prcData(train,end);
%     [net,performance,e]=TrainNeualNet(input,TargetOutputs);
%     output=prcData(train,1:end-1);
%     %     class = predict(Mdl,Featn(test,1:end-1));
%     class=net(prcData(test,1:end-1)');
%     %     class = classify(Feat(test,1:end-1),Feat(train,1:end-1),Feat(train,end));
%     classperf(cp,class,test);
% end
% finasl_errorRate=cp.ErrorRate;