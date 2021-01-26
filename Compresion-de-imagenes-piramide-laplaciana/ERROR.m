function [IMG_ERROR, rmse] = ERROR(IMG_G0,IMG_RECONSTRUIDA)

%Se redimencionan de las matrices para que sean iguales
[IMG_G0, IMG_RECONSTRUIDA] = redimensionar(IMG_G0, IMG_RECONSTRUIDA, 1, 2);


%Se calcula el error
IMG_ERROR = double(IMG_G0) - double(IMG_RECONSTRUIDA);
IMG_ERROR_1 = IMG_ERROR/256;
%IMG_ERROR_11 = IMG_ERROR_1 * 100;
IMG_ERROR_2 = sum(IMG_ERROR_1(:).^2);
rmse = sqrt(IMG_ERROR_2/(size(IMG_ERROR,1)*size(IMG_ERROR,2)))*100;
end

