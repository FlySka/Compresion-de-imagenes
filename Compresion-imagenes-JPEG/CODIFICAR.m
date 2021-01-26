function [diccionario, dim] = CODIFICAR(Matriz)

%Se reordenan las matrices zigzag en vectores  
for i=1:3
    MatrizZ{i} = zigzag(Matriz{i});
end

%Se codifican las matrices por separado
for t=1:3
    [bins{t}, val{t}, cant{t}] = CONTADOR_BINS(MatrizZ{t});
    probabilidad = cant{t}(:)/sum(cant{t}(:));
    diccionario{t} = huffmandict(val{t}(:), probabilidad);
    codificado{t} = huffmanenco(MatrizZ{t}(:),diccionario{t});
end

dim = zeros(1,3);
%Se guardan encabezado de dimencion de matrices codificadas
for b=1:3
    dim(b) = size(codificado{b},1);
end

%guardando bits, primero hay que concatenar
IMG_CONCT = codificado{1}';
for g=2:3
    IMG_CONCT = [IMG_CONCT  codificado{g}'];
end

%Luego, se guardan en archivo binario .bin
data = fopen('IMG_COMPRIMIDA.bin','w');
fwrite(data, IMG_CONCT, 'ubit1');
fclose(data);

end

