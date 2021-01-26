function [decodificado] = DECODIFICAR(DIM_COD, DIM_COMPR, DICC, reduccion)

%Se lee el archivo de base de datos
data = fopen('IMG_COMPRIMIDA.bin', 'r');
img_datos = fread(data,'ubit1');
fclose(data);

%Se extraen los distintos L y el ultimo G comprimidos
dim_ant = 0;
for i=1:reduccion+1
    img_de{i} = img_datos(dim_ant+1:dim_ant+DIM_COD(1,i),1);
    dim_ant = dim_ant + DIM_COD(1,i);
end

%Se Decodifican los datos
for j=1:reduccion+1
IMG_DICC{j} = huffmandeco(img_de{j}, DICC{j});
end

%Se reordenan las matrices con las dimensiones reales
contador = 1;
for n=1:reduccion+1
    for j=1:DIM_COMPR(n,2)
        for i=1:DIM_COMPR(n,1)
            decodificado{n}(i,j) = IMG_DICC{n}(contador);
            contador = contador + 1;
        end
    end
    contador = 1;
end

end

