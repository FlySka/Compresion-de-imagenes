%Compresion de imagenes con SVD
%joaquin Farias
%Procesamiento moderno de señales

clear all

%Se extre los datos de la imagen original.
IMG_ORIGINAL = double(imread('fogata.jpg'));

fprintf('Hola, este es un programa para comprimir imagenes mediante SVD.\n')
prompt = 'Por favor ingrese el porcentaje de valores singulares: ';

%se guarda el porcentaje de valores singulares ha ocupar.
porcentaje = input(prompt);

%Se comprime la imagen dependiendo del porcentaje ingresado
tic_kmeans = tic;
[U, E, V] = comprimir(IMG_ORIGINAL, porcentaje);
toc_kmeans = toc(tic_kmeans);

%Se reconstruye la imagen que comprimida anteriormente
tic_recon = tic;
[IMG_RECON] = recomprimir(U, E, V);
toc_recon = toc(tic_recon);

%calculo de error
tic_error = tic;
[error, img_prom_erroresRGB] = calc_error(IMG_ORIGINAL,IMG_RECON);
error = num2str(error);
fprintf('Error de imagen compilada: %s %%\n',error);
toc_error = toc(tic_error);

%se muestran en pantalla los tiempos de ejecucion de los algoritmos
fprintf('\nTiempo de ejecucion de algoritmo de compresion con SVD: %d seg.\n',toc_kmeans);
fprintf('Tiempo de ejecucion de algoritmo de recompresion: %d seg.\n',toc_recon);
fprintf('Tiempo de ejecucion de algoritmo de calculo de error: %d seg.\n',toc_error);
toc_total = toc_kmeans + toc_recon + toc_error;
fprintf('Tiempo de ejecucion de algoritmo completo: %d seg.\n',toc_total);

%Se muestra la imagen original
subplot(2, 2, 1);
imagesc(uint8(IMG_ORIGINAL));
title('Imagen original');

%Se muestra la imagen comprimida
subplot(2, 2, 2);
imagesc(IMG_RECON); 
title('Imagen comprimida');

%Se muestra mapa de errores por pixel de la imagen original comparada con
%la imagen comprimida.
subplot(2,2,3);
imagesc(img_prom_erroresRGB, [0,1]); title(['Error por pixel con un ',num2str(porcentaje),'% de VS'])
colorbar; colormap jet(256); axis off; axis image;

%Se muestra el SVD de la imagen
subplot(2,2,4);
plot(diag(E(:,:,1)+E(:,:,2)+E(:,:,3)),'LineWidth',2); title('SVD');

imwrite(IMG_RECON,'fogata_comprimida.jpeg','JPEG');