function  plot_k(xyEB, k, nx, ny, nkmax, map, EBstring, jtime, ntime, dt)
  Z = zeros(nx/2, ny/2);
  Y = abs(fft2(cell2mat(xyEB(k)), nx,ny)) / (nx*ny); % Yはnx行, ny列の行列
  for j =2:ny/2
    for i = 2:nx/2
      Z(i,j)= Y(i,j) + Y(nx-i+2, ny-j+2);
    end
  end 
  for j = 2:ny/2
    Z(1,j) = Y(1,j) + Y(1,ny-j+2);
  end
  for i = 2:nx/2
    Z(i,1) = Y(i,1) + Y(nx-i+2,1);
  end
  Z(1,1) = Y(1,1); 
  KK = 1:nkmax+1;

  ax(k) = subplot(2, 3, k); sc = imagesc(Z(KK,KK)');
  colormap(map); colorbar; shading flat;
  ax(k).DataAspectRatio = [100, 100, 1];
  sc(1).XData = 0:nkmax; sc(1).YData = 0:nkmax;
  ax(k).XLim = [0, 20]; ax(k).YLim = [0, 20]; 
  ax(k).YDir = 'normal';
  % if k <= 3
  %   ax(k).ZLim = [0, 0.6];
  % else
  %   ax(k).ZLim = [0, 0.04];
  % end
  ax(k).XLabel.String = 'kx(mode)'; ax(k).YLabel.String = 'ky(mode)';
  ax(k).ZLabel.String = cell2mat(EBstring(k));
  ax(k).Title.String = sprintf('Time = %10.3f / %10.3f', jtime*dt, ntime*dt);
end