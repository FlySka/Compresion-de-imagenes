function [matriz1, matriz2] = redimensionar(matriz1, matriz2, reduccion1, modo)

%Se redimencionan de las matrices para que sean iguales
if modo == 1
for i = 1:reduccion1
    m = size(matriz1{i},1) - size(matriz2{i},1);
    n = size(matriz1{i},2) - size(matriz2{i},2);
    if m > 0
        for j=1:m
        matriz1{i}(size(matriz1{i},1),:) = []; 
        end
    elseif m < 0
        for j=1:m*-1
        matriz2{i}(size(matriz2{i},1),:) = [];
        end
    end
    if n > 0
        for j=1:n
        matriz1{i}(:,size(matriz1{i},2)) = [];
        end
    elseif n < 0
        for j=1:n*-1
        matriz2{i}(:,size(matriz2{i},2)) = [];
        end
    end
end
end

%Se redimencionan de las matrices para que sean iguales
if modo == 2
    matriz1 = double(matriz1);
    matriz2 = double(matriz2);
    m = size(matriz1,1) - size(matriz2,1);
    n = size(matriz1,2) - size(matriz2,2);
    if m > 0
        for j=1:m
            matriz1(size(matriz1,1),:) = [];
        end
    elseif m < 0
        for j=1:m*-1
        matriz2(size(matriz2,1),:) = [];
        end
    end
    if n > 0
        for j=1:n
        matriz1(:,size(matriz1,2)) = []; 
        end
    elseif n < 0
        for j=1:n*-1
        matriz2(:,size(matriz2,2)) = [];
        end
    end
end

end

