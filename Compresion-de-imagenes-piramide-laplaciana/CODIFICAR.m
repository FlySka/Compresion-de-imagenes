function [diccionario, dim, IMG_CONCT] = CODIFICAR(comprimido, reduccion)

%Se codifican las matrices por separado
for t=1:reduccion+1
    [bins{t}, val{t}, cant{t}] = CONTADOR_BINS(comprimido{t});
    probabilidad = cant{t}(:)/sum(cant{t}(:));
    diccionario{t} = huffmandict(val{t}(:), probabilidad);
    codificado{t} = huffmanenco(comprimido{t}(:),diccionario{t});
end

%Se guardan encabezado de dimencion de matrices codificadas
dim = zeros(1,reduccion+1);
for b=1:reduccion+1
    dim(b) = size(codificado{b},1);
end

%guardando bits, primero hay que concatenar
IMG_CONCT = codificado{1}';
for g=2:reduccion+1
    IMG_CONCT = [IMG_CONCT  codificado{g}'];
end

%Luego, se guardan en archivo binario .bin
data = fopen('IMG_COMPRIMIDA.bin','w');
fwrite(data, IMG_CONCT, 'ubit1');
fclose(data);

end

