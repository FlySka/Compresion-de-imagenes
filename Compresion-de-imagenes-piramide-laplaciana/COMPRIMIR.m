function [IMG_COMPR, DIM_COMPR, cuantizador, cantidad, valores] = COMPRIMIR(IMG_LA, IMG_G0, reduccion, porcentaje)

%Se extrae la informacion de los histogramas
for  i=1:reduccion
    [cantidad{i},valores{i}] = hist(IMG_LA{i}(:),size(IMG_LA{i},1)*size(IMG_LA{i},2));
end

%Se calcula una cuantizacion adaptativa segun nivel de laplaciana
porcentaje_resta = round(porcentaje/reduccion);
for i=1:reduccion
    numero_porcentaje = size(valores{i},2)*(1-(porcentaje(i)/100));
    cuantizador(i) = size(valores{i},2)/numero_porcentaje;
    if i == reduccion
        break;
    end
    porcentaje(i+1) = porcentaje(i) - porcentaje_resta;
end

%Se cuantizan las Laplacianas
for i=1:reduccion
    IMG_COMPR{i} = round(IMG_LA{i}/cuantizador(i));
end
IMG_COMPR{reduccion+1} = IMG_G0;

%Se guardan dimansiones de las matrices de los L comprimidos
DIM_COMPR = zeros(reduccion+1,2);
for i=1:reduccion+1
    DIM_COMPR(i,1) = size(IMG_COMPR{i},1); 
    DIM_COMPR(i,2) = size(IMG_COMPR{i},2); 
end
end

