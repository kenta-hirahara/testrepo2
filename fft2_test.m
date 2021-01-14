clear;
nx=16;
ny=16;
nxh = nx/2;
nyh = ny/2;
m=1;
n=0;
kx = 2*pi/nx*m;
ky = 2*pi/ny*n;
X = zeros(nx,ny);
Z = zeros(nxh, nyh);
for j =1:ny
    for i=1:nx
        phi = kx*i+ky*j+pi/4;
        X(i,j) = cos(phi);
    end
end
Y = fft2(X, nx,ny)/(nx*ny);
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
    
contour(transpose(Z));

