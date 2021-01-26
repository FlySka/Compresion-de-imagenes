function [IMG_RECON] = recomprimir(U, E, V)

%Se reconstruyen las matrices RGB.
R = U(:,:,1) * E(:,:,1) * (V(:,:,1))';
G = U(:,:,2) * E(:,:,2) * (V(:,:,2))';
B = U(:,:,3) * E(:,:,3) * (V(:,:,3))';

%se calcula la matriz de salida que contiene las matrices U, E y V de las
%matrices RGB.
IMG_RECON = uint8(cat(3, R, G, B));

end

