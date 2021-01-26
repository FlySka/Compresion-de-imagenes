function [IMG_EXP] = EXPAND(IMG_EXP_G, reduccion, w2, modo)

%se expanden todas las imagenes G
if modo == 1
for i=reduccion+1:-1:2
    IMG_EXP1{i-1} = uint8(zeros(2*size(IMG_EXP_G{i},1)-1,2*size(IMG_EXP_G{i},2)-1)); %se forma una matriz con zeros
    IMG_EXP1{i-1}(1:2:end, 1:2:end) = IMG_EXP_G{i}; %se une con la matriz reducida
    IMG_EXP{i-1} = imfilter(IMG_EXP1{i-1},4*w2,'same'); %Se filtra
end
end


%Expansion para la reconstruccion
if modo == 2
IMG_EXP_G = uint8(IMG_EXP_G);
IMG_EXP = uint8(zeros(2*size(IMG_EXP_G)-1)); %se forma una matriz con zeros
IMG_EXP(1:2:end, 1:2:end) = uint8(IMG_EXP_G); %se une con la matriz reducida
IMG_EXP = imfilter(IMG_EXP,4*w2,'same'); %Se filtra
end
end

