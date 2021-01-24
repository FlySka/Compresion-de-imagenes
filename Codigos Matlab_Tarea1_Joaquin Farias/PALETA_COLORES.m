function [paletita] = PALETA_COLORES(centros)

for i=1:3
paletita = zeros(400,800,3);
end

n=0;
for i=1:8
    for k=1:400
        for j=1:100
            paletita(k,j+n,:) = centros(i,:);    
        end
    end
    n = n + 100;
end

