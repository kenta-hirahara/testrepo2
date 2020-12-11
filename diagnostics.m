%diagnostics at an interval of dt*ndskip
xyEB = {ex(X2,Y2)*rne, ey(X2,Y2)*rne, ez(X2,Y2)*rne, (bx(X2,Y2)-bx0)*rnb, (by(X2,Y2)-by0)*rnb, (bz(X2,Y2)-bz0)*rnb}; %これは全プロットで使うのでここに固定
if mod(jtime, ndskip) == 0 %ndskipつまり8の倍数の時だけ描画
  energy;
  % figure of xy plot
  if xyEorBplot
    f_xy = figure(1); f_xy.Position = [0, 0, 1000, 750];
    set(0,'DefaultFigureColormap',jet)
    frames_xy = getframe(f_xy);

    for k =1:6
      ax(k) = subplot(2, 3, k);surf(cell2mat(xyEB(k))');
      ax(k).XLabel.String = 'X'; ax(k).YLabel.String = 'Y'; ax(k).ZLabel.String = cell2mat(EBstring(k));
      ax(k).XLim = [0, 20]; ax(k).YLim = [0, 20];
      if k <= 3
        ax(k).ZLim = [-4, 4];
      else
        ax(k).ZLim = [-0.5, 1];
      end
      if mod(jtime, 10) == 0 
        ax(k).Title.String = ['time = ',num2str(floor(jtime*dt)), '/', num2str(ntime*dt)];
      else
        ax(k).Title.String = ['time = ',num2str(floor((jtime-mod(jtime, 10))*dt)), '/', num2str(ntime*dt)];
      end
    end
    writeVideo(v_xyEorB, frames_xy);
  end

  % fxigure of kxky plot
  if kxkyPlot
    f_kxky = figure(2); f_kxky.Position = [0, 0, 1000, 750];
    frames_kxky = getframe(f_kxky);

    nxh = nx/2;
    nyh = ny/2;
    nkmax = 20;
    
    for k =1:6
      plot_k(xyEB, k, nx, ny, nkmax, EBstring);
      % Z = zeros(nxh, nyh);
      % Y = fft2(cell2mat(xyEB(k)), nx,ny)/(nx*ny);    
      % for j =2:nyh
      %   for i = 2:nxh
      %     Z(i,j)= abs(Y(i,j)) + abs(Y(nx-i+2, ny-j+2));
      %   end
      % end
      % for j = 2:nyh
      %   Z(1,j) =abs(Y(1,j)) + abs(Y(1,ny-j+2));
      % end
      % for i = 2:nxh
      %   Z(i,1) = abs(Y(i,1)) + abs(Y(nx-i+2,1));
      % end
      % Z(1,1) = abs(Y(1,1)); 
      % KK = 1:nkmax+1;
      % NXP = 0:nkmax;
      % NYP = 0:nkmax;
      % ax(k) = subplot(2, 3, k); sc = surfc(Z(KK,KK)');
      % sc(1).XData = NXP; sc(1).YData = NYP;
      % ax(k).XLim = [0, 20]; ax(k).YLim = [0, 20]; 
      % if k <= 3
      %   ax(k).ZLim = [0, 0.6];
      % else
      %   ax(k).ZLim = [0, 0.04];
      % end
      % ax(k).XLabel.String = 'kx(mode)'; ax(k).YLabel.String = 'ky(mode)';
      % ax(k).ZLabel.String = cell2mat(EBstring(k));
    end
    writeVideo(v_kxkyEorB, frames_kxky);
  end

  % figure of velocity distribution plot
  if velocityDistPlot
    f_velocitydist = figure(3);
    f_velocitydist.Position = [0, 0, 0, 0];
    
    n2 = 0;
    for  k=1:ns
      n1 = n2 + 1;
      n2 = n2 + np(k);

      ignoreAxis(k) = subplot(2,2,k);
      
      i = n1:n2;
      h(k) = histogram2(vx(i), sqrt(vy(i).*vy(i) + vz(i).*vz(i)));
      h(k).XBinLimits = [-1*cv, cv];
      h(k).YBinLimits = [0, cv];
      h(k).NumBins = [2*num_v+1, num_v+1];
      editableHistogram(1, k) = {h(k).Values};
      editableHistogram(1, k) = {cell2mat(editableHistogram(1, k)) ./ (pi*((cv/num_v)^3) * div) * abs(q(k))}; 
    end

    editedVelocityDist = figure(4);
    editedVelocityDist.Position = [400, 400, 1200, 600];
    frames_velocitydist = getframe(editedVelocityDist);
    
    for k=1:ns
      ax(k) = subplot(1, 2, k); surfaceHist= surf(cell2mat(editableHistogram(1, k)));

      surfaceHist.XData = perp;
      surfaceHist.YData = para;
      % surfaceHist.LevelList = 200;
      
      if jtime == ndskip
        zmax(k) = max(cell2mat(editableHistogram(1, k)), [], 'all'); 
        % sprintf( 'zmax(%d) is %d', k, zmax(k))
      end
      % sprintf( '[0, zmax(%d)] is %d  %d', k, 0, zmax(k))
      ax(k).XLim = [0, cv]; ax(k).YLim = [-1*cv, cv]; ax(k).ZLim = [0, zmax(k)];
      ax(k).XLabel.String = 'v_{perp}'; ax(k).YLabel.String = 'v_{para}';
      
      if mod(jtime, 10) == 0 
        ax(k).Title.String = ['time = ',num2str(floor(jtime*dt)), '/', num2str(ntime*dt)]
      else
        ax(k).Title.String = ['time = ',num2str(floor((jtime-mod(jtime, 10))*dt)), '/', num2str(ntime*dt)]
      end
    end
    writeVideo(v_velocitydist, frames_velocitydist);
  end

  % figure of EJ plot
  % if EJplot
    
  % end
end

% Diagnostics at the end of the job 
%  plotting time history of energies
if itime == ntime
  % fign_xy = fign_xy+1;
  figure(5);
  frame = getframe(gcf);
IT=(1:it);
  pt = IT*dt*ndskip;
  if ns==2
    semilogy(pt, engt, pt, eepara,pt, eeperp,pt,ebpara,pt,ebperp,pt,ke(IT,1),pt,ke(IT,2));
    legend('total','e-para','e-perp','b-para','b-perp','sp1','sp2');
  elseif ns==3
    semilogy(pt, engt, pt, eepara,pt, eeperp,pt,ebpara,pt,ebperp,pt,ke(IT,1),pt,ke(IT,2),pt,ke(IT,3));
    legend('total','e-para','e-perp','b-para','b-perp','sp1','sp2','sp3');
  end
  title('Energy History');
  %plotting time history of temperature anisotropy
  % fign_xy = fign_xy+1;
  figure(6);
  plot(pt,At), xlabel('Time'),ylabel('Temperature Anisotropy');
  if ns==2
      legend ('sp1','sp2');
  elseif ns ==3
      legend('sp1','sp2', 'sp3');
  end
  % fign_xy = fign_xy-1;
end; 