function [BINS, valores, cantidad] = CONTADOR_BINS(matriz)
distinto = 0;
cantidad(1,1) = 0;
BINS = 1;
valores(1,1) = matriz(1,1);
for i=1:size(matriz,1)
    for j=1:size(matriz,2)
        for k=1:size(valores,2)
            if valores(1,k) == matriz(i,j)
                distinto = distinto + 1;
                cantidad(1,k) = cantidad(1,k) + 1;
            end
        end
        if distinto == 0
            valores(1,BINS+1) = matriz(i,j);
            cantidad(1,BINS+1) = 1;
            BINS = BINS + 1;
        end
        distinto = 0;
    end
end
end

