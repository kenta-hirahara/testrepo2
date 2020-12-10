%diagnostics at an interval of dt*ndskip

if mod(jtime, ndskip) == 0 %ndskipつまり8の倍数の時だけ描画
  energy;
  % figure of xy plot
  if xyEorBplot
    f_xy = figure(1); f_xy.Position = [0, 0, 1000, 750];
    set(0,'DefaultFigureColormap',jet)
    frames_xy = getframe(f_xy);

    ax1 = subplot(2, 3, 1); surf(ex(X2,Y2)'*rne)
    ax1.XLabel.String = 'X'; ax1.YLabel.String = 'Y'; ax1.ZLabel.String = 'Ex';
    ax1.XLim = [0, 20]; ax1.YLim = [0, 20]; ax1.ZLim = [-4, 4];
    if mod(jtime, 10) == 0 
      ax1.Title.String = ['time = ',num2str(floor(jtime*dt)), '/', num2str(ntime*dt)]
    else
      ax1.Title.String = ['time = ',num2str(floor((jtime-mod(jtime, 10))*dt)), '/', num2str(ntime*dt)]
    end
    ax2 = subplot(2, 3, 2); surf(ey(X2,Y2)'*rne)
    ax2.XLabel.String = 'X'; ax2.YLabel.String = 'Y'; ax2.ZLabel.String = 'Ey';
    ax2.XLim = [0, 20]; ax2.YLim = [0, 20]; ax2.ZLim = [-4, 4];
    if mod(jtime, 10) == 0 
      ax2.Title.String = ['time = ',num2str(floor(jtime*dt)), '/', num2str(ntime*dt)]
    else
      ax2.Title.String = ['time = ',num2str(floor((jtime-mod(jtime, 10))*dt)), '/', num2str(ntime*dt)]
    end
    ax3 = subplot(2, 3, 3); surf(ez(X2,Y2)'*rne)
    ax3.XLabel.String = 'X'; ax3.YLabel.String = 'Y'; ax3.ZLabel.String = 'Ez';
    ax3.XLim = [0, 20]; ax3.YLim = [0, 20]; ax3.ZLim = [-4, 4];
    if mod(jtime, 10) == 0 
      ax3.Title.String = ['time = ',num2str(floor(jtime*dt)), '/', num2str(ntime*dt)]
    else
      ax3.Title.String = ['time = ',num2str(floor((jtime-mod(jtime, 10))*dt)), '/', num2str(ntime*dt)]
    end
    ax4 = subplot(2, 3, 4); surf((bx(X2,Y2)-bx0)'*rnb)
    ax4.XLabel.String = 'X'; ax4.YLabel.String = 'Y'; ax4.ZLabel.String = 'Bx';
    ax4.XLim = [0, 20]; ax4.YLim = [0, 20]; ax4.ZLim = [-0.5, 1];
    if mod(jtime, 10) == 0 
      ax4.Title.String = ['time = ',num2str(floor(jtime*dt)), '/', num2str(ntime*dt)]
    else
      ax4.Title.String = ['time = ',num2str(floor((jtime-mod(jtime, 10))*dt)), '/', num2str(ntime*dt)]
    end
    ax5 = subplot(2, 3, 5); surf((by(X2,Y2)-by0)'*rnb)
    ax5.XLabel.String = 'X'; ax5.YLabel.String = 'Y'; ax5.ZLabel.String = 'By';
    ax5.XLim = [0, 20]; ax5.YLim = [0, 20]; ax5.ZLim = [-0.5, 1];
    if mod(jtime, 10) == 0 
      ax5.Title.String = ['time = ',num2str(floor(jtime*dt)), '/', num2str(ntime*dt)]
    else
      ax5.Title.String = ['time = ',num2str(floor((jtime-mod(jtime, 10))*dt)), '/', num2str(ntime*dt)]
    end
    ax6 = subplot(2, 3, 6); surf((bz(X2,Y2)-bz0)'*rnb)
    ax6.XLabel.String = 'X'; ax6.YLabel.String = 'Y'; ax6.ZLabel.String = 'Bz';
    ax6.XLim = [0, 20]; ax6.YLim = [0, 20]; ax6.ZLim = [-0.5, 1];
    if mod(jtime, 10) == 0 
      ax6.Title.String = ['time = ',num2str(floor(jtime*dt)), '/', num2str(ntime*dt)]
    else
      ax6.Title.String = ['time = ',num2str(floor((jtime-mod(jtime, 10))*dt)), '/', num2str(ntime*dt)]
    end
    writeVideo(v_xyEorB, frames_xy);
  end

  % fxigure of kxky plot
  if kxkyPlot
    f_kxky = figure(2); f_kxky.Position = [0, 0, 1000, 750];
    frames_kxky = getframe(f_kxky);

    ax1 = subplot(2, 3, 1); plot_kxkyEx
    ax1.XLabel.String = 'kx'; ax1.YLabel.String = 'ky'; ax1.ZLabel.String = 'Ex';
    ax1.XLim = [0, 20]; ax1.YLim = [0, 20]; ax1.ZLim = [0, 0.8];
    ax2 = subplot(2, 3, 2); plot_kxkyEy
    ax2.XLabel.String = 'kx'; ax2.YLabel.String = 'ky'; ax2.ZLabel.String = 'Ey';
    ax2.XLim = [0, 20]; ax2.YLim = [0, 20]; ax2.ZLim = [0, 0.3];
    ax3 = subplot(2, 3, 3); plot_kxkyEz  
    ax3.XLabel.String = 'kx'; ax3.YLabel.String = 'ky'; ax3.ZLabel.String = 'Ez';
    ax3.XLim = [0, 20]; ax3.YLim = [0, 20]; ax3.ZLim = [0, 0.3];
    ax4 = subplot(2, 3, 4); plot_kxkyBx
    ax4.XLabel.String = 'kx'; ax4.YLabel.String = 'ky'; ax4.ZLabel.String = 'Bx';
    ax4.XLim = [0, 20]; ax4.YLim = [0, 20]; ax4.ZLim = [0, 0.04];
    ax5 = subplot(2, 3, 5); plot_kxkyBy
    ax5.XLabel.String = 'kx'; ax5.YLabel.String = 'ky'; ax5.ZLabel.String = 'By';
    ax5.XLim = [0, 20]; ax5.YLim = [0, 20]; ax5.ZLim = [0, 0.04];
    ax6 = subplot(2, 3, 6); plot_kxkyBz
    ax6.XLabel.String = 'kx'; ax6.YLabel.String = 'ky'; ax6.ZLabel.String = 'Bz';
    ax6.XLim = [0, 20]; ax6.YLim = [0, 20]; ax6.ZLim = [0, 0.04];
    
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