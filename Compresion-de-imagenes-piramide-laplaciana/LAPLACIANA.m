function [IMG_LA] = LAPLACIANA(IMG_G, IMG_E, reduccion)


%Se redimencionan de las matrices para que sean iguales
[IMG_G, IMG_E] = redimensionar(IMG_G, IMG_E, reduccion, 1);

%Se forma la piramida laplaciana
%Se forma la piramida laplaciana
for i = reduccion:-1:1
    IMG_LA{i} = double(IMG_G{i}) - double(IMG_E{i}); 
end

end

