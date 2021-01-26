function [Y_W,Cb_W,Cr_W,Sy,Scb,Scr] = WAVELETS(Y, Cb, Cr, d)

%Se encogen las matrices de crominancia
Cb = imresize(Cb,size(Cb)/d);
Cr = imresize(Cr,size(Cr)/d);

%Se hace la transformada final
[Y_W,Sy] = wavedec2(double(Y),5,'db4');
[Cb_W,Scb] = wavedec2(double(Cb),5,'db4');
[Cr_W,Scr] = wavedec2(double(Cr),5,'db4');

   
end

