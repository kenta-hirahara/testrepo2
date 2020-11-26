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

  ax1 = subplot(2, 3, 1); surf(ex(X2,Y2)'*rne),
  ax1.XLabel.String = 'X'; ax1.YLabel.String = 'Y'; ax1.ZLabel.String = 'Ex';
  ax1.XLim = [0, 20]; ax1.YLim = [0, 20]; ax1.ZLim = [-4, 4]; 
  
  ax2 = subplot(2, 3, 2); surf(ey(X2,Y2)'*rne),
  xlabel('X'), ylabel('Y'),zlabel('Ey');
  ax2.XLim = [0, 20]; ax2.YLim = [0, 20]; ax2.ZLim = [-4, 4]; 

  ax3 = subplot(2, 3, 3); surf(ez(X2,Y2)'*rne),
  xlabel('X'), ylabel('Y'),zlabel('Ez');
  ax3.XLim = [0, 20]; ax3.YLim = [0, 20]; ax3.ZLim = [-4, 4]; 

  ax4 = subplot(2, 3, 4); surf((bx(X2,Y2)-bx0)'*rnb),
  xlabel('X'), ylabel('Y'),zlabel('Bx');
  ax4.XLim = [0, 20]; ax4.YLim = [0, 20]; ax4.ZLim = [-1, 2]; 

  ax5 = subplot(2, 3, 5); surf((by(X2,Y2)-by0)'*rnb),
  xlabel('X'), ylabel('Y'),zlabel('By');
  ax5.XLim = [0, 20]; ax5.YLim = [0, 20]; ax5.ZLim = [-1, 2];

  ax6 = subplot(2, 3, 6); surf((bz(X2,Y2)-bz0)'*rnb),
  xlabel('X'), ylabel('Y'),zlabel('Bz');
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

  f_velocitydist = figure(4); f_kxky.Position = [1200, 600, 1000, 750];
  frames_velocitydist = getframe(f_velocitydist);

  ax1 = subplot(1, 1, 1);
  h = histogram2(vx, sqrt(vy.*vy + vz.*vz));
  h.XBinLimits = [-1*cv, cv];
  h.YBinLimits = [0, cv];
  h.NumBins = [2*num_v, num_v];

  editableHistgram = h.Values;

  editableHistgram = editableHistgram ./ [1:num_v];
  editableHistgram = editableHistgram';
  im = image(editableHistgram);
  im.Parent = ax1;
  im.CDataMapping = 'scaled';

  ax1.XLabel.String = 'v_para'; ax5.YLabel.String = 'v_perp';

  writeVideo(v_velocitydist, frames_velocitydist);
end

% Diagnostics at the end of the job
%  plotting time history of energies
if itime == ntime
  % fign_xy = fign_xy+1;
  figure(3);
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
  figure(4);
  plot(pt,At), xlabel('Time'),ylabel('Temperature Anisotropy');
  if ns==2
      legend ('sp1','sp2');
  elseif ns ==3
      legend('sp1','sp2', 'sp3');
  end     
  % fign_xy = fign_xy-1;
end;
