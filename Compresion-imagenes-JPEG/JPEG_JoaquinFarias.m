%Implementacion de formato de compresion JPEG
%joaquin Farias
%Procesamiento moderno de señales

clear
clc

fprintf('Hola, este es un programa que implementa el formate JPEG en una imagen.\n')
prompt = 'Por favor ingrese el factor de calidad que desea, Q = ';
Q = input(prompt);

%Se extre los datos de la imagen original.
IMG_ORIGINAL = imread('ola.jpg');

%Se transpasa la imagen a formato YCbCr
IMG_YCbCr = double(rgb2ycbcr(IMG_ORIGINAL));
IMG_Y = IMG_YCbCr(:,:,1);
%Se encogen las matrices de crominancia
IMG_Cb = imresize(IMG_YCbCr(:,:,2),size(IMG_YCbCr(:,:,2))/2);
IMG_Cr = imresize(IMG_YCbCr(:,:,3),size(IMG_YCbCr(:,:,3))/2);

%Se calcua matriz DCT y se hace la transformada
[IMG_Y_DCT,IMG_Cb_DCT,IMG_Cr_DCT,dctMatriz,mean] = DCT(IMG_Y, IMG_Cb, IMG_Cr);

%Se crea matriz de cuantizacion de 8x8, depende del factor Q
[Qmatriz] = GENERACION_MQ(Q);

%Se cuantizan los canales de la imagen
[IMG_Q] = CUANTIZAR(IMG_Y_DCT,IMG_Cb_DCT,IMG_Cr_DCT,Qmatriz);

%Se codifican y se guardan los archivos comprimidos
[DICC, DIM_COD] = CODIFICAR(IMG_Q); %Codificacion con Huffman

for i=1:3
    DIM_COMPR(i,:) = size(IMG_Q{i}); %se guardan dimenciones reales de las matrices cuantizadas
end
save('ENCABEZADOS.dat','DIM_COD','DIM_COMPR', 'DICC', 'Qmatriz','dctMatriz','mean');%Se guardan los encabezados
    
%Se guardan los archivos que se plotearan. Estas matrices no se ocupan para
%la decodificacion.
save('ploteo.dat','IMG_ORIGINAL');




%---------------------------DECODIFICACION---------------------------------
clear all %Se limpian todas las variables anteriores
%--------------------------------------------------------------------------




%Se leen los archivos comprimidos y se decodifica
load('ENCABEZADOS.dat','-mat','DIM_COD','DIM_COMPR', 'DICC', 'Qmatriz','dctMatriz','mean'); %Se leen los encabezados
[IMG_COMPRIMIDA] = DECODIFICAR(DIM_COD, DIM_COMPR, DICC); %Se decodifica la imagen

%Se reconstruye la imagen
[IMG_JPEG] = DECUANTIZAR(IMG_COMPRIMIDA,Qmatriz,dctMatriz,mean);

%Se leen los archivos que se plotearan
load('ploteo.dat','-mat','IMG_ORIGINAL');

%Se calcula de error
[IMG_ERROR,rmse] = ERROR(IMG_ORIGINAL,IMG_JPEG);

%Se muestra la imagen original
subplot(1, 3, 1);
imshow(uint8(IMG_ORIGINAL));
title(' Imagen original ');

%Se muestra la imagen reconstruida
subplot(1, 3, 2);
imshow(IMG_JPEG); 
title('Imagen Reconstruida');

%Se muestra el error entre imagen original y reconstruida
s = subplot(1, 3, 3);
imshow(IMG_ERROR,[-10,10]);
colorbar; colormap(s,'jet'); axis off; axis image;
title('[Error]');

%Se muestra el error en pantalla
rmse = num2str(rmse);
fprintf('\nRMSE = %s%%\n', rmse);


imwrite(uint8(IMG_JPEG),'ola_reconstruida.jpeg','JPEG');