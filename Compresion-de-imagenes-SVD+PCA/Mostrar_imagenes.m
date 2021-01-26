%Guardar y abrir datos comprimidos a punto flotante (EIE754)
%joaquin Farias
%Procesamiento moderno de señales

clear all
parpool(2);
%Se extre los datos de la imagen original.
IMG_ORIGINAL = double(imread('fogata.jpg'));

fprintf('Hola, este es un programa para guardar y abrir los datos SVD.\nde la imagen en punto flotante (IEEE754).\n')
prompt = 'Por favor ingrese el porcentaje de valores singulares: ';

%se guarda el porcentaje de valores singulares ha ocupar.
porcentaje = input(prompt);

%Se comprime la imagen dependiendo del porcentaje ingresado
tic_kmeans = tic;
[U, E, V] = comprimir(IMG_ORIGINAL, porcentaje);
toc_kmeans = toc(tic_kmeans);

%Se hace la transformacion a binario

%defino variables
entero_bin_U = zeros(size(U));
entero_bin_E = zeros(size(E));
entero_bin_V = zeros(size(V));

%obtengo el numero con decimales en binario
h=1;
for k=1:3
    for i=1:size(U,1)
        for j=1:size(U,2)
            p(1) = U(i,j,k);
            entero_bin_U(i,j,k) = str2double([dec2bin(U(i,j,k)) '.']);
            while and(h<23-size(entero_bin_U(i,j,k),2), p(h)~=0)
                h=h+1;
                p(h)=((p(h-1)-floor(p(h-1)))*2);
                entero_bin_U(i,j,k) = str2double([entero_bin_U(i,j,k) dec2bin(p(h))]);
            end
            U_flot(i,j,k) = entero_bin_U(i,j,k); 
            h=1;
            p(:)=0;
        end
    end
end
for k=1:3
    for i=1:size(E,1)
        for j=1:size(E,2)
            p(1) = E(i,j,k);
            entero_bin_E(i,j,k) = str2double([dec2bin(E(i,j,k)) '.']);
            while and(h<23-size(entero_bin_E(i,j,k),2), p(h)~=0)
                h=h+1;
                p(h)=((p(h-1)-floor(p(h-1)))*2);
                entero_bin_E(i,j,k) = str2double([entero_bin_E(i,j,k) dec2bin(p(h))]);
            end 
            E_flot(i,j,k) = entero_bin_E(i,j,k);
            h=1;
            p(:)=0;
        end
    end
end
for k=1:3
    for i=1:size(V,1)
        for j=1:size(V,2)
            p(1) = V(i,j,k);
            entero_bin_V(i,j,k) = str2double([dec2bin(V(i,j,k)) '.']);
            while and(h<23-size(entero_bin_V(i,j,k),2), p(h)~=0)
                h=h+1;
                p(h)=((p(h-1)-floor(p(h-1)))*2);
                entero_bin_V(i,j,k) = str2double([entero_bin_V(i,j,k) dec2bin(p(h))]);
            end
            V_flot(i,j,k) = entero_bin_V(i,j,k); 
            h=1;
            p(:)=0;
        end
    end
end

%Se guardan los datos en una BD puesta en unos archivos .txt

