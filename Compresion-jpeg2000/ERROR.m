function [IMG_ERROR_f,rmse] = ERROR(IMG_G,IMG_RECONSTRUIDA)

%Se calcula el error
IMG_ERROR = double(IMG_G) - double(IMG_RECONSTRUIDA);
IMG_ERROR_f = (IMG_ERROR(:,:,1)+IMG_ERROR(:,:,2)+IMG_ERROR(:,:,3))/3;

IMG_ERROR1 = IMG_ERROR(:,:,1);
IMG_ERROR2 = IMG_ERROR(:,:,2);
IMG_ERROR3 = IMG_ERROR(:,:,3);

rmse1 = sqrt(mean(IMG_ERROR1(:)).^2 );
rmse2 = sqrt(mean(IMG_ERROR2(:)).^2 );
rmse3 = sqrt(mean(IMG_ERROR3(:)).^2 );


rmse = (rmse1 + rmse2 + rmse3)/3;
end

