function [IMG_RECONSTRUIDA] = RECONSTRUCCION(IMG_COMPRI, cuantizador, w2, reduccion)

%Se vuelve al histograma de antes de la compresion
for i=1:reduccion
    IMG_COMPR_RE{i} = IMG_COMPRI{i}*cuantizador(i);
end

%Se guarda el valor de G(n), para asi hacer la reconstruccion con sus
%expansiones y los valores L de la piramide laplaciana
IMG_RE_G{reduccion} = IMG_COMPRI{reduccion+1};
IMG_LA = IMG_COMPRI;
%Se reconstruye la foto
for i = reduccion:-1:1
    
    %Se obtiene la expandida de G{i}
    IMG_RE_E{i} = EXPAND(IMG_RE_G{i}, i, w2, 2);
    
    %Se redimensionan las matrices para que sean iguales
    [IMG_LA{i}, IMG_RE_E{i}] = redimensionar(IMG_LA{i}, IMG_RE_E{i}, i, 2);
    
    %Se reconstruye la imagen G{i+1};
    IMG_RE{i} = double(IMG_LA{i}) + double(IMG_RE_E{i});
    if i == 1 
        break; %se sale del loop si es reconstruido G(0)
    end
    IMG_RE_G{i-1} = IMG_RE{i};
end

%Se guarda la imagen reconstruida
IMG_RECONSTRUIDA = IMG_RE{1};

end

