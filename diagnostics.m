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
      plot_xy(xyEB, k, EBstring, jtime, ntime ,dt)
    end
    writeVideo(v_xyEorB, frames_xy);
  end

  % fxigure of kxky plot
  if kxkyPlot
    f_kxky = figure(2); f_kxky.Position = [0, 0, 1000, 750];
    frames_kxky = getframe(f_kxky);

    nkmax = 20;
    for k =1:6
      plot_k(xyEB, k, nx, ny, nkmax, EBstring, jtime, ntime, dt);
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
      plot_velocityDist(editableHistogram, k, perp, para, cv, jtime, ndskip, dt, ntime)
    end
    writeVideo(v_velocitydist, frames_velocitydist);
  end
  % figure of w-kx-ky diagram
  if wkxky
    f_wkxky = figure(5);
    f_wkxky.Position = [100, 100, 1000, 700]

    kxkyt = zeros(nkmax+1, nkmax+1, ntime)
    for i=1:ntime
      Z = zeros(nx/2, ny/2);
      Y = abs(fft2(cell2mat(xyEB(k)), nx,ny)) / (nx*ny); 
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
      kykxt(i) = Z(KK,KK); %ここでk空間の行列の要素数を一気に減らす、これをnplot(ntimeの約数, とりあえずntime)回して格納した. 
    end
    % 以降で時間方向にfft
    kxkyw = fft(kxkyt, ntime, 3);


  % figure of EJ plot
  % if EJplot
    
  % end
end

% Diagnostics at the end of the job 
%  plotting time history of energies
if itime == ntime
  % fign_xy = fign_xy+1;
  figure(8);
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
  savefig(strcat('energyHistory_', fileWithStartTime, '.fig'))
  %plotting time history of temperature anisotropy
  % fign_xy = fign_xy+1;
  figure(9);
  plot(pt,At), xlabel('Time'),ylabel('Temperature Anisotropy');
  if ns==2
      legend ('sp1','sp2');
  elseif ns ==3
      legend('sp1','sp2', 'sp3');
  end
  savefig(strcat('Anisotropy_', fileWithStartTime, '.fig'))
  % fign_xy = fign_xy-1;
end; 