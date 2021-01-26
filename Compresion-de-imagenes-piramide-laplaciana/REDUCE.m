function [IMG_G, w2] = REDUCE(IMG_ORIGINAL, reduccion)
%Se cambia el nombre de la matriz de la imgen por orden
IMG_PRO = double(IMG_ORIGINAL); 
IMG_G{1} = double(IMG_ORIGINAL);

%Parametros filtro Gausiano.
a = 0.4;
w = [((1/4)-(a/2)) (1/4) a (1/4) ((1/4)-(a/2))];
w2 = w'*w;

for i=2:reduccion+1
    %Ahora se filtrara la imagen 
    IMG_FIL = imfilter(IMG_PRO, w2, 'full');

    %Ahora se hara la decimacion de la imagen
    IMG_DEC = IMG_FIL(1:2:end,1:2:end);
    
    %Se guarda la matriz Gl reducida en una concatenacion de matrices
    IMG_G{i} = IMG_DEC;

    IMG_PRO = IMG_DEC;
end
end

