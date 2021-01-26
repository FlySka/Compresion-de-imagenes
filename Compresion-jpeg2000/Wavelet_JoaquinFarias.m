%Implementacion de compresion de imagenes a color con Wavelets
%joaquin Farias
%Procesamiento moderno de señales

clear
clc

fprintf('Hola, este es un programa que comprime una imagen a color mediante Wavelets.\n')
prompt = 'Por favor ingrese porcentaje de compresion que desea(0-100): ';
C = input(prompt);
%Se calcula el parametro para la cuantizacion
Q = 5*power(10,-13)*exp(0.3836*C);
if Q < 1
    Q = 2;
end
d = 4;

%Se extre los datos de la imagen original.
IMG_ORIGINAL = imread('ola.jpg');

%Se transpasa la imagen a formato YCbCr
IMG_YCbCr = double(rgb2ycbcr(IMG_ORIGINAL));
IMG_Y = IMG_YCbCr(:,:,1);
IMG_Cb = IMG_YCbCr(:,:,2);
IMG_Cr = IMG_YCbCr(:,:,3);

%Se hace la transformada de wavelet a los canales
[IMG_Y_W,IMG_Cb_W,IMG_Cr_W,Sy,Scb,Scr] = WAVELETS(IMG_Y, IMG_Cb, IMG_Cr,d);

%Se cuantizan los canales de la imagen
[IMG_Q] = CUANTIZAR(IMG_Y_W,IMG_Cb_W,IMG_Cr_W,Q);

%Se codifican y se guardan los archivos comprimidos
[DICC, DIM_COD] = CODIFICAR(IMG_Q); %Codificacion con Huffman

for i=1:3
    DIM_COMPR(i,:) = size(IMG_Q{i}); %se guardan dimenciones reales de las matrices cuantizadas
end
save('ENCABEZADOS.dat','DIM_COD','DIM_COMPR', 'DICC', 'Sy','Scb','Scr','d');%Se guardan los encabezados
    
%Se guardan los archivos que se plotearan. Estas matrices no se ocupan para
%la decodificacion.
save('ploteo.dat','IMG_ORIGINAL');




%---------------------------DECODIFICACION---------------------------------
%clear all %Se limpian todas las variables anteriores
%--------------------------------------------------------------------------




%Se leen los archivos comprimidos y se decodifica
load('ENCABEZADOS.dat','-mat','DIM_COD','DIM_COMPR', 'DICC', 'Sy','Scb','Scr','d'); %Se leen los encabezados
[IMG_COMPRIMIDA] = DECODIFICAR(DIM_COD, DIM_COMPR, DICC); %Se decodifica la imagen

%Se reconstruye la imagen
[IMG_JPEG2k] = IWAVELETS(IMG_COMPRIMIDA,Sy,Scb,Scr,d);

%Se leen los archivos que se plotearan
load('ploteo.dat','-mat','IMG_ORIGINAL');

%Se calcula de error
[IMG_ERROR,rmse] = ERROR(IMG_ORIGINAL,IMG_JPEG2k);

%Se muestra la imagen original
subplot(1, 3, 1);
imshow(uint8(IMG_ORIGINAL));
title(' Imagen original ');

%Se muestra la imagen reconstruida
subplot(1, 3, 2);
imshow(uint8(IMG_JPEG2k)); 
title('Imagen Reconstruida');

%Se muestra el error entre imagen original y reconstruida
s = subplot(1, 3, 3);
imshow(IMG_ERROR,[-50,50]);
colorbar; colormap(s,'jet'); axis off; axis image;
title('[Error]');

%Se muestra el error en pantalla
rmse = num2str(rmse*100);
fprintf('\nRMSE = %s%%\n', rmse);

fileInfo = dir('IMG_COMPRIMIDA.bin');
tamano  = fileInfo.bytes;
fileInfo = dir('ENCABEZADOS.dat');
tamano = (tamano + fileInfo.bytes - 5000)/1000;
tamano = num2str(tamano);
fprintf('\narchivo .bin + encabezados = %s KB\n', tamano);
imwrite(uint8(IMG_JPEG2k),'ola_reconstruida.jpeg','JPEG');