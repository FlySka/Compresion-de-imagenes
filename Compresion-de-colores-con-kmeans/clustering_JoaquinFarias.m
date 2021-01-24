%Clustering de RGB de imagen por medio del algoritmo k-means
%joaquin Farias
%Procesamiento moderno de señales

clc
clear 

%Se extre los datos de la imagen original
IMG_ORIGINAL = imread('fogata.jpg');

fprintf('Hola, Este es un programa para compilar colores RGB de imagenes mediante \n el algoritmo K-means.\n')
prompt = 'Ingrese un valor para K = ';

%se elije el numero de conjuntos K
K = input(prompt);

%Se compila la imagen con el algoritmo k-means en K conjuntos
tic_kmeans = tic;
[IMG_COMP, IMG_IDX] = COLORCOMP(IMG_ORIGINAL, K);
toc_kmeans = toc(tic_kmeans);

%Se recompila la imagen que comprimimos anteriormente
tic_recon = tic;
[IMG_RECON] = COLORDECOMP(IMG_COMP,IMG_IDX);
toc_recon = toc(tic_recon);

%calculo de error
tic_error = tic;
[error] = calc_error(IMG_ORIGINAL,IMG_RECON);
error = num2str(error);
fprintf('Error de imagen compilada: %s %%\n',error);
toc_error = toc(tic_error);

%se muestran en pantalla los tiempos de ejecucion de los algoritmos
fprintf('\nTiempo de ejecucion de algoritmo K-means: %d seg.\n',toc_kmeans);
fprintf('Tiempo de ejecucion de algoritmo de recompilacion: %d seg.\n',toc_recon);
fprintf('Tiempo de ejecucion de algoritmo de calculo de error: %d seg.\n',toc_error);
toc_total = toc_kmeans + toc_recon + toc_error;
fprintf('Tiempo de ejecucion de algoritmo completo: %d seg.\n',toc_total);

%Se muestra la imagen original
subplot(1, 2, 1);
imagesc(IMG_ORIGINAL);
axis image;
title('Imagen original');

%Se muestra la imagen comprimida
subplot(1, 2, 2);
imagesc(IMG_RECON);
title('Imagen comprimida');

%imwrite(IMG_RECON,'patron.jpeg','JPEG');

%cambiando cambiando
