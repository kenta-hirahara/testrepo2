%diagnostics at an interval of dt*ndskip
num_v = 100;
if mod(jtime,ndskip) == 0 %ndskipつまり8の倍数の時だけ描画
  energy;
  % figure of xy plot
  f_xy = figure(fign_xy); f_xy.Position = [200, 0, 1000, 750];
  set(0,'DefaultFigureColormap',jet)
  frames_xy = getframe(f_xy);
  %%同じplot関数(下の例ではplot_xyEorB)にしておいて、GUIのdropdoun.valueが変わるとplot関数の引数が変わるようにしたい%%
  %% ax1 = subplot(2, 3, 1);plot_xyEorB(panel1)
  %% ax2 = subplot(2, 3, 2);plot_xyEorB(panel2)
  %% ax3 = subplot(2, 3, 3);plot_xyEorB(panel3)
  %%のような感じ
  ax1 = subplot(2, 3, 1); surf(ex(X2,Y2)'*rne)
  ax1.XLabel.String = 'X'; ax1.YLabel.String = 'Y'; ax1.ZLabel.String = 'Ex';
  ax1.XLim = [0, 20]; ax1.YLim = [0, 20]; ax1.ZLim = [-4, 4];
  
  ax2 = subplot(2, 3, 2); surf(ey(X2,Y2)'*rne)
  ax2.XLabel.String = 'X'; ax2.YLabel.String = 'Y'; ax2.ZLabel.String = 'Ey';
  ax2.XLim = [0, 20]; ax2.YLim = [0, 20]; ax2.ZLim = [-4, 4];

  ax3 = subplot(2, 3, 3); surf(ez(X2,Y2)'*rne)
  ax3.XLabel.String = 'X'; ax3.YLabel.String = 'Y'; ax3.ZLabel.String = 'Ez';
  ax3.XLim = [0, 20]; ax3.YLim = [0, 20]; ax3.ZLim = [-4, 4];

  ax4 = subplot(2, 3, 4); surf((bx(X2,Y2)-bx0)'*rnb)
  ax4.XLabel.String = 'X'; ax4.YLabel.String = 'Y'; ax4.ZLabel.String = 'Bx';
  ax4.XLim = [0, 20]; ax4.YLim = [0, 20]; ax4.ZLim = [-1, 2];

  ax5 = subplot(2, 3, 5); surf((by(X2,Y2)-by0)'*rnb)
  ax5.XLabel.String = 'X'; ax5.YLabel.String = 'Y'; ax5.ZLabel.String = 'By';
  ax5.XLim = [0, 20]; ax5.YLim = [0, 20]; ax5.ZLim = [-1, 2];

  ax6 = subplot(2, 3, 6); surf((bz(X2,Y2)-bz0)'*rnb)
  ax6.XLabel.String = 'X'; ax6.YLabel.String = 'Y'; ax6.ZLabel.String = 'Bz';
  ax6.XLim = [0, 20]; ax6.YLim = [0, 20]; ax6.ZLim = [-1, 2];
  
  writeVideo(v_xyEorB, frames_xy);

  % figure of kxky plot
  f_kxky = figure(fign_kxky); f_kxky.Position = [1200, 0, 1000, 750];
  frames_kxky = getframe(f_kxky);

  ax1 = subplot(2, 3, 1); plot_kxkyEx
  ax1.XLabel.String = 'kx'; ax1.YLabel.String = 'ky'; ax1.ZLabel.String = 'Ex';
  ax1.XLim = [0, 20]; ax1.YLim = [0, 20]; ax1.ZLim = [0, 0.3];
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

  % figure of velocity distribution plot
  n2 = 0;
  for  k=1:ns
    n1 = n2 + 1;
    n2 = n2 + np(k);
    i = n1:n2
    f_velocitydist = figure(2+k); f_velocitydist.Position = [1200, 600, 1000, 750];
    frames_velocitydist = getframe(f_velocitydist);
    ax = axes();
    h = histogram2(vx(i), sqrt(vy(i).*vy(i) + vz(i).*vz(i)));
    h.XBinLimits = [-1*cv, cv];
    h.YBinLimits = [0, cv];
    h.NumBins = [2*num_v, num_v];

    editableHistgram = h.Values;
    div = 2*[1:num_v] - 1;
    editableHistgram = editableHistgram ./ (pi*((cv/num_v)^3) * div);

    im = surfc(editableHistgram);
    im.Parent = ax;
    % im.CDataMapping = 'scaled';
    ax.XLabel.String = 'v_{perp}'; ax.YLabel.String = 'v_{para}';
    writeVideo(v_velocitydist, frames_velocitydist);
  end
  
end
% Diagnostics at the end of the job
%  plotting time history of energies
if itime == ntime
  % fign_xy = fign_xy+1;
  figure(7);
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
  figure(8);
  plot(pt,At), xlabel('Time'),ylabel('Temperature Anisotropy');
  if ns==2
      legend ('sp1','sp2');
  elseif ns ==3
      legend('sp1','sp2', 'sp3');
  end
  % fign_xy = fign_xy-1;
end;