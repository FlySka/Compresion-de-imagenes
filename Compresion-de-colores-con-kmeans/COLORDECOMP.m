function [IMG_RECON] = COLORDECOMP(IMG_COMP,IMG_IDX)
%transforma las matrices de compilacion en una imagen
fprintf('\nRecompilando Imagen\n');

%Variables
Rp = zeros(size(IMG_COMP,1), size(IMG_COMP,2));
Gp = zeros(size(IMG_COMP,1), size(IMG_COMP,2));
Bp = zeros(size(IMG_COMP,1), size(IMG_COMP,2));

%obtener los nuevos vectores RGB
for i=1:size(IMG_COMP,1)
    for j=1:size(IMG_COMP,2)
        for k=1:size(IMG_IDX,1)
            if IMG_COMP(i,j)==k
                Rp(i,j) = IMG_IDX(k,1);
                Gp(i,j) = IMG_IDX(k,2);
                Bp(i,j) = IMG_IDX(k,3);
            end
        end
    end

%resultado de salida
IMG_RECON = uint8(cat(3,Rp, Gp, Bp));

end

