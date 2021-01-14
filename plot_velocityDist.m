function zmax = plot_velocityDist(surfORimagesc, editableHistogram, ns, perp, para, cv, jtime, ndskip, dt, ntime, zmax, map)
  % surface plot of velocity distribution
  m = ns;
  n = 1;
  
  global zmax
  for k = 1:ns
    ax(k) = subplot(m, n, k);
    editedHist = cell2mat(editableHistogram(1, k))';
  
    switch surfORimagesc
      case 0
        surf(para, perp, editedHist); % surfaceHist.LevelList = 200;
      case 1
        imagesc(para, perp, editedHist);
      case 2
        contourf(para, perp, editedHist);
      end
    colormap(map); colorbar;
  
    if jtime == ndskip
      zmax(k) = max(editedHist, [], 'all');
    end
    % sprintf( '[0, zmax(%d)] is %d  %d', k, 0, zmax(k))
    % ax(k).XLim = [-1*cv, cv]; ax(k).YLim = [0, cv];
    ax(k).YDir = 'normal';
    % ax(k).ZLim = [0, zmax(k)];
    ax(k).XLabel.String = 'v_{para}'; ax(k).YLabel.String = 'v_{perp}';
    ax(k).DataAspectRatio = [100, 100, 1];
    ax(k).Title.String = sprintf('Time = %10.3f / %10.3f', jtime*dt, ntime*dt);
    
  end
end