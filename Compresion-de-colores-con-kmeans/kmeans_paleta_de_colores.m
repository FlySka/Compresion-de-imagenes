%Clustering de RGB de imagen por medio del algoritmo k-means
%Y paleta de colores
%joaquin Farias
%Procesamiento moderno de señales

clc
clear 

%Se extre los datos de la imagen original
IMG_ORIGINAL = imread('fogata.jpg');

fprintf('Hola, Este es un programa para compilar colores RGB de imagenes mediante \n el algoritmo K-means.\n')
prompt = 'Ingrese un valor para K = ';

%se elije el numero de conjuntos K
K = 8;

%Se compila la imagen con el algoritmo k-means en K conjuntos
tic_kmeans = tic;
[IMG_COMP, IMG_IDX] = COLORCOMP(IMG_ORIGINAL, K);
toc_kmeans = toc(tic_kmeans);

%se muestran en pantalla los tiempos de ejecucion de los algoritmos
fprintf('\nTiempo de ejecucion de algoritmo K-means: %d seg.\n',toc_kmeans);

%Se muestra la imagen original
subplot(2, 1, 1);
imshow(uint8(IMG_ORIGINAL));

[PALETA] = PALETA_COLORES(IMG_IDX);

%Se muestra la imagen paleta de colores
subplot(2, 1, 2);
imshow(uint8(PALETA));

%imwrite(IMG_RECON,'patron.jpeg','JPEG');