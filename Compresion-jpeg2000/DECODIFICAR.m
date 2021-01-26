function [decodificado] = DECODIFICAR(DIM_COD, DIM_COMPR, DICC)

%Se lee el archivo de base de datos
data = fopen('IMG_COMPRIMIDA.bin', 'r');
img_datos = fread(data,'ubit1');
fclose(data);

%Se extraen las matrices cuantizadas
dim_ant = 0;
for i=1:3
    img_de{i} = img_datos(dim_ant+1:dim_ant+DIM_COD(1,i),1);
    dim_ant = dim_ant + DIM_COD(1,i);
end

%Se Decodifican los datos
for j=1:3
IMG_DICC{j} = huffmandeco(img_de{j}, DICC{j});
end

%Se reordenan las matrices con las dimensiones reales
for n=1:3
    decodificado{n} = izigzag(IMG_DICC{n}',DIM_COMPR(n,1),DIM_COMPR(n,2));
end

end

