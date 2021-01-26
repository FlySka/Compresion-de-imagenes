%Compresion de imagenes con Piramida Laplaciana
%joaquin Farias
%Procesamiento moderno de señales

clear 
clc

%Se extre los datos de la imagen original.
IMG_ORIGINAL = imread('ola.jpg');
%Se transpasa la imagen a escala de grises
IMG_ORIGINAL = rgb2gray(IMG_ORIGINAL);
IMG_ORIGINAL = IMG_ORIGINAL(1:end-1,1:end-1);

%Se define la cantidad de iteraciones del algoritmo de Piramida Laplaciana
reduccion = 6;

fprintf('Hola, este es un programa para comprimir imagenes mediante Piramide Laplaciana.\n\n')
prompt = 'Por favor ingrese el porcentaje de compresion que desea: ';

%Se transforma el porcentaje de compresion a un parametro ocupado para la
%compresion, que tiene que ver con el porcentaje de BINS ocupados para 
%comprimir el histograma.
%Para comparar la compresion se sumo el archivo .bin con las compresiones
%de los L y el Gn, ademas del archivo .dat con lo encabezados necesarios
%para descomprimir. Esto se hizo despues de variar pruebas con distintos
%valores.
porcnt_comp = input(prompt);
porcentaje = 0.0006*power(porcnt_comp,3) - 0.116*power(porcnt_comp,2) + 7.9042*porcnt_comp - 108.57;

%Se comprime la imagen dependiendo del porcentaje ingresado
[IMG_G, w2] = REDUCE(IMG_ORIGINAL, reduccion);

%Se expanden las imagenes G con la funcion EXPAND
[IMG_E] = EXPAND(IMG_G, reduccion, w2, 1);

%Se hace la Piramide Laplaciana
[IMG_LA] = LAPLACIANA(IMG_G, IMG_E, reduccion);

%Se comprimen los datos de la imagen
[IMG_COMPR, DIM_COMPR, cuantizador, cantidad, valores] = COMPRIMIR(IMG_LA, IMG_G{reduccion+1}, reduccion, porcentaje);

%Se codifican y se guardan los archivos comprimidos
[DICC, DIM_COD, conct] = CODIFICAR(IMG_COMPR, reduccion); %Codificacion con Huffman
save('ENCABEZADOS.dat','DIM_COD','DIM_COMPR', 'DICC', 'reduccion', 'cuantizador','w2');%Se guardan los encabezados

%Se guardan los archivos que se plotearan. Estas matrices no se ocupan para
%la decodificacion.
save('ploteo.dat','IMG_G','IMG_ORIGINAL','IMG_E','IMG_LA');




%---------------------------DECODIFICACION---------------------------------
clear all %Se limpian todas las variables anteriores
%--------------------------------------------------------------------------




%Se leen los archivos comprimidos
load('ENCABEZADOS.dat','-mat','DIM_COD','DIM_COMPR', 'DICC', 'reduccion','cuantizador','w2'); %Se leen los encabezados
[IMG_COMPRIMIDA] = DECODIFICAR(DIM_COD, DIM_COMPR, DICC, reduccion); %Se decodifica la imagen

%Se reconstruye la imagen
[IMG_RECONSTRUIDA] = RECONSTRUCCION(IMG_COMPRIMIDA, cuantizador, w2, reduccion);

%Se leen los archivos que se plotearan
load('ploteo.dat','-mat','IMG_G','IMG_ORIGINAL','IMG_E','IMG_LA');

%Se calcula de error
[IMG_ERROR,rmse] = ERROR(IMG_G{1},IMG_RECONSTRUIDA);


%Se muestra la imagen original
subplot(1, 3, 1);
imshow(uint8(IMG_G{1}));
title(' Imagen original ');

%Se muestra las imagen G(N-1)
%subplot(2, 3, 4);
%imshow(uint8(IMG_G{reduccion-1})); 
%title([' Imagen Piramide Gausiana G' int2str(reduccion-1)]);

%Se muestra la imagen expandida E(n-1) 
%subplot(2, 3, 5);
%imshow(uint8(IMG_E{reduccion-1})); 
%title([' Imagen Expandida E' int2str(reduccion-1)]);

%Se muestra las imagen L(n-1) de la Piramide Laplaciana
%subplot(2, 3, 6);
%imshow(IMG_LA{reduccion-1}); 
%title([' Imagen Piramide Laplaciana L' int2str(reduccion-1)]);

%Se muestra la imagen reconstruida
subplot(1, 3, 2);
imshow(uint8(IMG_RECONSTRUIDA)); 
title(' Imagen Reconstruida ');

%Se muestra el error entre imagen original y reconstruida
s = subplot(1, 3, 3);
imshow(IMG_ERROR,[-20,20]);
colorbar; colormap(s,'jet'); axis off; axis image;
title(' Error ');

%Se muestra el error en pantalla
rmse = num2str(rmse);
fprintf('\nRMSE = %s%%\n', rmse);


imwrite(uint8(IMG_RECONSTRUIDA),'ola_reconstruida.jpeg','JPEG');
%imwrite(uint8(IMG_ORIGINAL),'ola_ORIGINAL_B&N.jpeg','JPEG');