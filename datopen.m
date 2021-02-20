function [out_matrix ] = datopen(filename,satr,sotoon)

band1 = fopen(filename);
b = zeros(satr,sotoon);
a = fread(band1);
for i=1:satr
    b(i,1:sotoon)=a((i-1)*sotoon+1:sotoon*i,1);
end
out_matrix = b ;

end

