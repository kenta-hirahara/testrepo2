%program to plot kx-ky spectrum of the field
nxh = nx/2;
nyh = ny/2;
Z = zeros(nxh, nyh);

Y = fft2((bx(X2,Y2)-bx0)*rnb, nx,ny)/(nx*ny);
fcomp = 'Bx';

for j =2:nyh
    for i = 2:nxh
    Z(i,j)= abs(Y(i,j)) + abs(Y(nx-i+2, ny-j+2));
    end
end
for j = 2:nyh
    Z(1,j) =abs(Y(1,j)) + abs(Y(1,ny-j+2));
end
for i = 2:nxh
    Z(i,1) = abs(Y(i,1)) + abs(Y(nx-i+2,1));
end
Z(1,1) = abs(Y(1,1)); 
%nkmax =< nxh
nkmax = 20;
KK = 1:nkmax+1;
NXP = 0:nkmax; 
NYP = 0:nkmax;
surfc(NXP, NYP,transpose(Z(KK,KK))), 
xlabel('kx (mode)'), ylabel('ky (mode)'),zlabel(fcomp),axis('square'),
title(['time = ',num2str(jtime*dt)]), 
hold off;