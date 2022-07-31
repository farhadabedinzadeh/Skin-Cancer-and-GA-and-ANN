function feature=get_feature(mat,mask,c)

%GLCM matrix
glcm = graycomatrix(mat,'NumLevels',50);
% GLRLM matrix 
[SRE,LRE,GLN,RP,RLN,FRAC,glrlm]   = calc_glrlm(mat,16,ones(size(mat)));

feat.SRE=SRE;
feat.GLN=GLN;
feat.LRE=LRE;
feat.RP=RP;
feat.RLN=RLN;
feat.FRAC=FRAC;
val=zeros(1,4);

for i=1:size(glcm,1)
    for j=1:size(glcm,2)
        val(1)=val(1)+((i-1)^2)*glcm(i,j);
        val(2)=val(2)+glcm(i,j)*glcm(i,j);
        val(3)=val(3)+(log10(glcm(i,j)+.1))*glcm(i,j);
        val(4)=val(4)+(glcm(i,j)/(1+abs(i-j)));
        
    end
end

feat.Contrast=val(1);
feat.Energy=val(2);
feat.Entropy=val(3);
feat.Homogeneit=val(4);


s = regionprops(mask,'Area','BoundingBox','ConvexArea','ConvexImage','Perimeter','MinorAxisLength','MajorAxisLength','Solidity','Eccentricity');


% R_mask_max=[];
% for Lw=100:-2:5
%     for ind=1:numel(x)
%         mat=mask(x(ind)-Lw:x(ind)+Lw,y(ind)-Lw:y(ind)+Lw);
%         if numel(find(mat==0)<5) 
%             R_mask_max=[R_mask_max ;x(ind) y(ind) Lw ];
%         end
%         
%     end
% end
% R_mask_min=[];
% for Lw=5:2:100
%     for ind=1:numel(x)
%         mat=mask(x(ind)-Lw:x(ind)+Lw,y(ind)-Lw:y(ind)+Lw);
%         if  numel(find(mat==1))>.98*numel(x)
%             R_mask_min=[R_mask_min ;x(ind) y(ind) Lw ];
%         end
%         
%     end
% end



s1 = regionprops(s.ConvexImage,'Perimeter');

vec=s.BoundingBox;
feat.Area=s.Area;
feat.Bounding_box=vec(3)*vec(4);
feat.rmin=vec(3)-2*c;
feat.rmax=vec(3);
feat.ConvexArea=s.ConvexArea;
feat.Convexpri=s1.Perimeter;
feat.Perimeter=s.Perimeter;
feat.Compactness=4*pi*s.Area/s.Perimeter;
feat.Elongation=vec(3)/vec(4);
feat.Roundness=(vec(3)-2*c)/vec(3);
feat.Convexity=(s1.Perimeter-s.Perimeter)/s.Perimeter;
feat.Spherity=sqrt((vec(3)-2*c)^2+(vec(4)-2*c)^2)/sqrt((vec(3))^2+(vec(4))^2);
feat.Solidity=s.Solidity;
feat.Moment=s.Eccentricity;


feature=[val(1) val(2) val(3) val(4) SRE GLN LRE RP RLN FRAC  ...
    feat.Area feat.Bounding_box feat.rmin feat.rmax ...
    feat.ConvexArea feat.Convexpri feat.Perimeter feat.Compactness ...
    feat.Elongation feat.Roundness feat.Convexity feat.Spherity ...
    feat.Solidity feat.Moment];
