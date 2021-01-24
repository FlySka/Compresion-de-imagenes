IMG_ORIGINAL = imread('C:\Users\joaqu\Desktop\Tarea1 Procesamiento moderno de señales\cuidad.jpg');
%IMG_ORIGINAL = IMG_ORIGINAL/256;
fprintf('Hola, Este es un programa para compilar colores RGB de imagenes mediante \n el algoritmo K-means. \n')
prompt = 'Ingrese un valor para K = ';
K = input(prompt);
%variables inciales
distancia = zeros(K,1);
centros_inicial = zeros(K,3);
centros_new = zeros(K,3);
centros_old = zeros(K,3);
cluster = zeros(size(IMG_ORIGINAL,1), size(IMG_ORIGINAL,2));
sumaR = 0;
sumaG = 0;
sumaB = 0;
cont = 0;

%Extraccion de caracteristicas
R = double(IMG_ORIGINAL(:,:,1));
G = double(IMG_ORIGINAL(:,:,2));
B = double(IMG_ORIGINAL(:,:,3));

%centroides iniciales
for i=1:K
    a = randperm(size(IMG_ORIGINAL,1),1);
    b = randperm(size(IMG_ORIGINAL,2),1);
    centros_inicial(i,:) = [R(a, b),G(a, b),B(a, b)];  
end

%asignacion inicial
cont_dist = 999999999;
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
        cont_dist = 999999999;
    end
end

