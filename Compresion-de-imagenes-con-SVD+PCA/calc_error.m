function [error, img_prom_erroresRGB] = calc_error(IMG_ORIGINAL,IMG_RECON)

%Extraccion de caracteristicas
R = double(IMG_ORIGINAL(:,:,1));
G = double(IMG_ORIGINAL(:,:,2));
B = double(IMG_ORIGINAL(:,:,3));
Rc = double(IMG_RECON(:,:,1));
Gc = double(IMG_RECON(:,:,2));
Bc = double(IMG_RECON(:,:,3));  

%variables
sum_errores = 0;
sum_errores = double(sum_errores);
img_erroresR = zeros(size(IMG_ORIGINAL,1),size(IMG_ORIGINAL,2));
img_erroresG = zeros(size(IMG_ORIGINAL,1),size(IMG_ORIGINAL,2));
img_erroresB = zeros(size(IMG_ORIGINAL,1),size(IMG_ORIGINAL,2));
img_prom_erroresRGB = [size(IMG_ORIGINAL,1),size(IMG_ORIGINAL,2)];

%calculo de errores en cada elemento de las matrices RGB
img_restaR = abs(R - Rc);
img_restaG = abs(G - Gc);
img_restaB = abs(B - Bc);
for i=1:size(IMG_ORIGINAL,1)
        for j=1:size(IMG_ORIGINAL,2)
            img_erroresR(i,j) = img_restaR(i,j) / 256;
            img_erroresG(i,j) = img_restaG(i,j) / 256;
            img_erroresB(i,j) = img_restaB(i,j) / 256;
        end
end

%calculo de error promedio en cada vector RGB
for i=1:size(IMG_ORIGINAL,1)
        for j=1:size(IMG_ORIGINAL,2)
            img_prom_erroresRGB(i,j) = img_erroresR(i,j) + img_erroresG(i,j) + img_erroresB(i,j);
        end
end
img_prom_erroresRGB(:,:) = img_prom_erroresRGB(:,:)/3;

%calculo de error promedio de la imagen compilada
for i=1:size(IMG_ORIGINAL,1)
        for j=1:size(IMG_ORIGINAL,2)
            sum_errores = sum_errores + img_prom_erroresRGB(i,j);
        end
end

%calculo de errores promedio final
total_posiciones = size(IMG_ORIGINAL,1) * size(IMG_ORIGINAL,2);
error = sum_errores / total_posiciones;
error = round(error*100,4,'significant');

end

