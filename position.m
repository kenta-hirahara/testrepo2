 % advancing position by half time step
  x = x + vx;
  y = y + vy;
 % periodic boundary condition 
  x = mod(x,xlen);
  y = mod(y,ylen);
  
