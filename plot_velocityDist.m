function plot_velocityDist(editableHistogram, ns, perp, para, cv, jtime, ndskip, dt, ntime, map, mapEJ, spName)
  % surface plot of velocity distribution
  global tmp_editedHist
  n = 2;

  for k = 1:ns
    ax(k) = subplot(ns, 2, 2*k-1);
    editedHist = cell2mat(editableHistogram(1, k))';
    imagesc(para, perp, editedHist);
    colormap(ax(k), map); colorbar;
    ax(k).YDir = 'normal';
    ax(k).XLabel.String = 'v_{para}'; ax(k).YLabel.String = 'v_{perp}';
    ax(k).DataAspectRatio = [100, 100, 1];
    ax(k).Title.String = sprintf('%s \n Time = %10.3f / %10.3f', cell2mat(spName(1+k)), jtime*dt, ntime*dt);
    
    diff_ax(k) = subplot(ns, 2, 2*k);
    imagesc(para, perp, editedHist-cell2mat(tmp_editedHist(1, k))');
    colormap(diff_ax(k), mapEJ); colorbar;
    diff_ax(k).YDir = 'normal';
    diff_ax(k).XLabel.String = 'v_{para}'; diff_ax(k).YLabel.String = 'v_{perp}';
    diff_ax(k).DataAspectRatio = [100, 100, 1];
    diff_ax(k).Title.String = sprintf('diff %s \n Time = %10.3f / %10.3f', cell2mat(spName(1+k)), jtime*dt, ntime*dt);

  end
end