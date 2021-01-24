function [IMG_COMP, IMG_IDX] = COLORCOMP(IMG_ORIGINAL, K)
%Funcion que extrae las caracteristicas de colores RGB de los pixeles de 
%la imagen y hace clustering mediante algoritmo k-means

%variables inciales *****************************************************
distancia = zeros(K,1);
centros_inicial = zeros(K,3);
centros_new = zeros(K,3);
cluster = zeros(size(IMG_ORIGINAL,1), size(IMG_ORIGINAL,2));
sumaR = 0;
sumaG = 0;
sumaB = 0;
cont = 0;
cont_dist = 9999999999;

%Extraccion de caracteristicas
R = double(IMG_ORIGINAL(:,:,1));
G = double(IMG_ORIGINAL(:,:,2));
B = double(IMG_ORIGINAL(:,:,3));

%Inicializacion*****************************************************************

%Establecer los primeros centroides
for i=1:K
    a = randperm(size(IMG_ORIGINAL,1),1);
    b = randperm(size(IMG_ORIGINAL,2),1);
    centros_inicial(i,:) = [R(a, b),G(a, b),B(a, b)];  
end

%asignacion inicial
for i=1:size(IMG_ORIGINAL,1)
    for j=1:size(IMG_ORIGINAL,2)
        for k=1:K
            distancia(k) = sqrt(power(centros_inicial(k,1)-R(i,j),2) + power(centros_inicial(k,2)-G(i,j),2) + power(centros_inicial(k,3)-B(i,j),2));
            if (distancia(k)<cont_dist)
                    contador_cluster = k;
                    cont_dist = distancia(k);
            end
        end
        cluster(i,j) = contador_cluster;
        cont_dist = 9999999999999;
    end
end

%Actualizacion y nueva asinacion ***************************************
for t=1:10

%numero de iteracion
fprintf("\nIteracion N° %d del algoritmo K-means.",t);

%obtener nuevos centros de grupos
for k=1:K
    for i=1:size(IMG_ORIGINAL,1)
        for j=1:size(IMG_ORIGINAL,2)
            if (cluster(i,j)==k)
                sumaR = sumaR + R(i,j);
                sumaG = sumaG + G(i,j);
                sumaB = sumaB + B(i,j);
                cont = cont + 1;
            end            
        end
    end
    if cont~=0
        promR = sumaR / cont;
        promG = sumaG / cont;
        promB = sumaB / cont;
        centros_new(k,:) = [round(promR), round(promG), round(promB)];
    end
    sumaR = 0;
    sumaG = 0;
    sumaB = 0;
    cont = 0;
end

%obtener nuevas asignaciones
cont_dist = 9999999999;
for i=1:size(IMG_ORIGINAL,1)
    for j=1:size(IMG_ORIGINAL,2)
        for k=1:K
            distancia(k) = sqrt(power(centros_new(k,1)-R(i,j),2) + power(centros_new(k,2)-G(i,j),2) + power(centros_new(k,3)-B(i,j),2));
            if (distancia(k)<cont_dist)
                    contador_cluster = k;
                    cont_dist = distancia(k);
            end
        end
        cluster(i,j) = contador_cluster;
        cont_dist = 99999999;
    end
end

end

%Resultado**************************************************************
IMG_COMP = cluster;
IMG_IDX = centros_new;

end

