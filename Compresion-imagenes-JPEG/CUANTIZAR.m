function [IMG_Q] = CUANTIZAR(IMG_Y_DCT,IMG_Cb_DCT,IMG_Cr_DCT,Qmatriz)
%Se cuantizan los canales de la imagen
cuantizacion = @(bloque) round( bloque.data ./ Qmatriz); %Funcion para cuantificar
IMG_YQ = blockproc(double(IMG_Y_DCT),[8 8],cuantizacion);
IMG_CbQ = blockproc(double(IMG_Cb_DCT),[8 8],cuantizacion);
IMG_CrQ = blockproc(double(IMG_Cr_DCT),[8 8],cuantizacion);

%Se une todo en un arreglo para meter a la funcion de codificacion
IMG_Q{1} = IMG_YQ;
IMG_Q{2} = IMG_CbQ;
IMG_Q{3} = IMG_CrQ;
end

