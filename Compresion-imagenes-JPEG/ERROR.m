function [IMG_ERROR_f,rmse] = ERROR(IMG_G,IMG_RECONSTRUIDA)

%Se calcula el error
IMG_ERROR = double(IMG_G) - double(IMG_RECONSTRUIDA);
IMG_ERROR_f = (IMG_ERROR(:,:,1)+IMG_ERROR(:,:,2)+IMG_ERROR(:,:,3))/3;
%IMG_ERROR_1 = IMG_ERROR/255;
%IMG_ERROR_2 = sum(IMG_ERROR_1(:).^2);
%rmse = sqrt(IMG_ERROR_2/(size(IMG_ERROR,1)*size(IMG_ERROR,2)))*100;

rmse = sqrt(mean(double(IMG_RECONSTRUIDA(:)) - double(IMG_G(:))).^2 );
end

