
data = fopen('IMG_COMPRIMIDA.bin', 'r');
img_datos = fread(data,'bit2');
fclose(data);


dim_ant = 0;
for i=1:reduccion+1
    img_de{i} = img_datos(dim_ant+1:dim_ant+DIM_COD(1,i),1);
    dim_ant = dim_ant + double(DIM_COD(i));
end
    
for j=1:reduccion+1
IMG_DICC{j} = huffmandeco(img_de{j}(:), DICC{j});
end

contador = 1;
for n=1:reduccion+1
    for j=1:DIM_COMPR(n,2)
        for i=1:DIM_COMPR(n,1)
            decodificado{n}(i,j) = IMG_DICC{n}(contador);
            contador= contador + 1;
        end
    end
    contador = 1;
end



