function [IMG_JPEG2k] = IWAVELETS(IMG_COMPRIMIDA,Sy,Scb,Scr,d)

S{1} = Sy;
S{2} = Scb;
S{3} = Scr;

%se hace la tranformada inversa
for i=1:3
IMG_COMPR{i} = waverec2(IMG_COMPRIMIDA{i},S{i},'db4');
end

%Se redimencionan las matrices de crominancia
IMG_COMPR{2} = imresize(IMG_COMPR{2},[size(IMG_COMPR{2})]*d);
IMG_COMPR{3} = imresize(IMG_COMPR{3},[size(IMG_COMPR{3})]*d);

for i=1:3
%Se une todo en un arreglo para plotear
IMG_JPG(:,:,i) = IMG_COMPR{i};
end

IMG_JPEG2k = ycbcr2rgb(uint8(IMG_JPG));
end

