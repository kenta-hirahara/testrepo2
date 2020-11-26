%  Initialization Variables
%
xlen = nx;
ylen = ny;
nxny = nx*ny;
g = 1.0;
npt =sum(np(1:ns));
b0 = wc/qm(1);

costh = cos(theta*pi/180);
sinth = sin(theta*pi/180);
cosph = cos(phi  *pi/180);
sinph = sin(phi  *pi/180);

bx0 = b0*sinth*cosph;
by0 = b0*sinth*sinph;
bz0 = b0*costh;
csq = cv*cv;
tcs = 2.0*csq;
it = 0;
  nxp1 = nx+1;
  nyp1 = ny+1;
  nxp2 = nx+2;
  nyp2 = ny+2;
  nxp3 = nx+3;
  nyp3 = ny+3;
  nxc = nx/2+1;
  nyc = ny/2+1;
  nxny = nx*ny;
  bx = ones(nxp2, nyp2)*bx0;
  by = ones(nxp2, nyp2)*by0;
  bz = ones(nxp2, nyp2)*bz0;
  ex = zeros(nxp2, nyp2);
  ey = zeros(nxp2, nyp2);
  ez = zeros(nxp2, nyp2);
  rho = zeros(nxp2, nyp2);
  psi = zeros(nxp2, nyp2);
  
% definition of inductive electric field
%  exind = zeros(nxp2, nyp2);
%  exind(nx/4+1:nx/4*3, ny/8*3+1:ny/8*5) = ones(nx/4*2, ny/8*2)*exinductive;

  
% Indiex Arry for Matrix Operation
  X1 = 1:nx;
  Y1 = 1:ny;
  X2 = 2:nxp1;
  Y2 = 2:nyp1;
  X3 = 3:nxp2;
  Y3 = 3:nyp2;
  V1 = 1:nxp1;
  V2 = 2:nxp2;
  VA = 1:nxp3;
  W1 = 1:nyp1;
  W2 = 2:nyp2;
  WA = 1:nyp3;
  A2 = 2:nx;
  B2 = 2:ny;
  A3 = 3:nxp1; 
  B3 = 3:nyp1;
% Paritlce Initialization
 x = zeros(1,npt);
 y = zeros(1,npt);
 vx = zeros(1,npt);
 vy = zeros(1,npt);
 vz = zeros(1,npt);

n2 = 0;
for  k=1:ns
  n1 = n2 + 1;
  n2 = n2 + np(k);
  pchr = pi/180.0*pch(k);
  vdpa = vd(k)*cos(pchr);
  vdpe = vd(k)*sin(pchr);

  x(n1:n2) = xlen*rand(1,np(k));
  % y(n1:n2) = ylen*rand(1,np(k));
  y(n1:n2) = ylen/np(k)*(1:np(k));

  %x(n1:n2) = xlen*0.5+0.1*xlen*randn(1,np(k));
  %y(n1:n2) = ylen*0.5+0.1*ylen*randn(1,np(k));
  for i = n1:n2
    phase = 2*pi*rand;
    uxi = vPerp(k)*randn + vdpe*cos(phase);
    uyi = vPerp(k)*randn + vdpe*sin(phase);
    uzi = vPara(k)*randn + vdpa; 
    
    % rotation to the direction of the magnetic field
    %座標変換しているので、uxが磁場に平行なx成分に必ずなるはず
    
    ux = uxi*costh*cosph - uyi*sinph + uzi*sinth*cosph;
    uy = uxi*costh*sinph + uyi*cosph + uzi*sinth*sinph;
    uz = -uxi*sinth                  + uzi*costh;
    % fprintf('cv: %d\n', cv)
    % fprintf('csq: %d\n', ux)
    % fprintf('ux: %d\n', ux)
    % fprintf('uy: %d\n', ux)
    % fprintf('uz: %d\n', uz)
    g = cv /sqrt(csq +ux*ux +uy*uy +uz*uz);
    % fprintf('ux: %d\n', ux)
    % fprintf('g: %d\n', g)
    vx(i) = ux*g;
    vy(i) = uy*g;
    vz(i) = uz*g;

  end
end
xcen = xlen*0.5;
ycen = ylen*0.5;
%for m = 1:np(1)
%  r = sqrt((x(m)-xcen)^2+(y(m)-ycen)^2);
%   if (r < 4.0) & (r >0.1) 
%      vx(m) = (x(m) - xcen)*vd(1)/r;
%      vy(m) = (y(m) - ycen)*vd(1)/r;
%   end
%end   
%
% Coefficiendts for Poisson Solver
rkfact = zeros(nx,ny);
rkxmin = pi/nx;
rkymin = pi/ny;
nxh = nx/2;
nyh = ny/2;
fftx = 1.0/nxh;
ffty = 1.0/nyh;
for j=3:ny
  rky = sin(rkymin*floor((j-1)/2))*2.0;
  for i=1:nx 
    rkx = sin(rkxmin*floor((i-1)/2))*2.0;
    rkfact(i,j) = 1.0/(rkx^2+rky^2);
  end
  rkx = 2.0;
  rkfact(2,j) = 1.0/(rkx^2+rky^2);
end
for i=3:nx 
  rkx = sin(rkxmin*floor((i-1)/2))*2.0;
  rkfact(i,1) = 1.0/(rkx^2);
end
rky = 2.0;
for i=3:nx 
   rkx = sin(rkxmin*floor((i-1)/2))*2.0;
   rkfact(i,2) = 1.0/(rkx^2+rky^2);
end
rkfact(1,2) = 1.0/(rky^2);
rkx = 2.0;
rkfact(2,2) = 1.0/(rkx^2+rky^2);
rkfact(2,1) = 1.0/(rkx^2);
rkfact(1,1) = 0.0;
%
q = (xlen*ylen)./np(1:ns).*(wp(1:ns).^2)./qm(1:ns);
mass = q./qm(1:ns);
rho0 = - sum(q(1:ns).*np(1:ns))/nxny*ones(nxp2,nyp2);

color = get(gca,'ColorOrder');
fign_xy = 1;
fign_kxky = 2;
itime = 0;
jtime = 0;
rmax = dx*nx;
rmin = 0.0;
%ke=zeros(ntime,ns);
