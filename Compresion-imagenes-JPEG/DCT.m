function [Matriz_transformada1,Matriz_transformada2,Matriz_transformada3,dctMatriz,mean] = DCT(Matriz1,Matriz2,Matriz3)

%Se obtiene la matriz DCT
dctMatriz = dctmtx(8);

%Se crea la funcion para hacer la DCT
dct = @(bloque) dctMatriz * bloque.data * dctMatriz';

%Se hace la tranformada en los 3 canales
Matriz_transformada1 = blockproc(double(Matriz1-mean2(Matriz1)),[8 8],dct);
Matriz_transformada2 = blockproc(double(Matriz2-mean2(Matriz2)),[8 8],dct);
Matriz_transformada3 = blockproc(double(Matriz3-mean2(Matriz3)),[8 8],dct);

%se guardan los promedios
mean(1) = mean2(Matriz1);
mean(2) = mean2(Matriz2);
mean(3) = mean2(Matriz3);
end

