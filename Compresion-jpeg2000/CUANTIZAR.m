function [IMG_Q] = CUANTIZAR(Y_W,Cb_W,Cr_W,Q)

%Se cuantizan los canales de la imagen
YQ = Q*round(Y_W/Q);
CbQ = log(Q)*Q*round(Cb_W/(Q*log(Q)));
CrQ = log(Q)*Q*round(Cr_W/(Q*log(Q)));

%CbQ = Q*round(Cb_W/Q);
%CrQ = Q*round(Cr_W/Q);

%Se une todo en un arreglo para meter a la funcion de codificacion
IMG_Q{1} = YQ;
IMG_Q{2} = CbQ;
IMG_Q{3} = CrQ;
end

