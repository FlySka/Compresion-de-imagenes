function [U, E, V] = comprimir(IMG_ORIGINAL, porcentaje)

%Primero se decomponen las matrices RGB con SVD.
[Ur, Er, Vr] = svd(IMG_ORIGINAL(:,:,1));
[Ug, Eg, Vg] = svd(IMG_ORIGINAL(:,:,2));
[Ub, Eb, Vb] = svd(IMG_ORIGINAL(:,:,3));

%Ahora de de acuerdo al porcentaje de valores singulares ha ocupar, se
%obtiene el numero exacto de ellos.
val_sing = round((size(Er,1) / 100) * porcentaje);

%Se empequeñesen las matrices de acuerdo al numero de valores singulares ha
%ocupar obtenido.
Erc = Er(1:val_sing, 1:val_sing);
Urc = Ur(:,1:val_sing);
Vrc = Vr(:,1:val_sing);

Egc = Eg(1:val_sing, 1:val_sing);
Ugc = Ug(:,1:val_sing);
Vgc = Vg(:,1:val_sing);

Ebc = Eb(1:val_sing, 1:val_sing);
Ubc = Ub(:,1:val_sing);
Vbc = Vb(:,1:val_sing);

U = cat(3, Urc, Ugc, Ubc);
E = cat(3, Erc, Egc, Ebc);
V = cat(3, Vrc, Vgc, Vbc);
end

