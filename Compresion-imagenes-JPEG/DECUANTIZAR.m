function [IMG_JPEG] = DECUANTIZAR(IMG_COMPRIMIDA_D,Qmatriz,dctMatriz,mean)

%Se decuantizan los canales de la imagen
decuantizacion = @(bloque) round( bloque.data .* Qmatriz); %Funcion para decuantificar
IMG_COMPRIMIDA_D{1} = blockproc(double(IMG_COMPRIMIDA_D{1}),[8 8],decuantizacion);
IMG_COMPRIMIDA_D{2} = blockproc(double(IMG_COMPRIMIDA_D{2}),[8 8],decuantizacion);
IMG_COMPRIMIDA_D{3} = blockproc(double(IMG_COMPRIMIDA_D{3}),[8 8],decuantizacion);

%Se hace la inversa de DCT
idct = @(bloque) dctMatriz' * bloque.data * dctMatriz;
for i=1:3
    IMG_COMPR{i} = blockproc(IMG_COMPRIMIDA_D{i},[8 8],idct);
end

%Se redimencionan las matrices de 
IMG_COMPR{2} = imresize(IMG_COMPR{2},[size(IMG_COMPR{2})]*2);
IMG_COMPR{3} = imresize(IMG_COMPR{3},[size(IMG_COMPR{3})]*2);

%Se une todo en un arreglo para plotear
for i=1:3
    IMG_JPG(:,:,i) = IMG_COMPR{i}+mean(i);
end

IMG_JPEG = ycbcr2rgb(uint8(IMG_JPG));
end

