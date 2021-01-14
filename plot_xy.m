function plot_xy(xyEB, map, k, EBstring, jtime, ntime ,dt)
  ax(k) = subplot(2, 3, k);imagesc(log10(abs(cell2mat(xyEB(k))')));
  colormap(map);  colorbar; shading flat; 
  caxis([-5, -2]);
  % caxis([-4, -1]); Eの範囲
  ax(k).DataAspectRatio = [100, 100, 1];
  ax(k).XLabel.String = 'X'; ax(k).YLabel.String = 'Y'; ax(k).ZLabel.String = cell2mat(EBstring(k));
  ax(k).XLim = [1, 21];
  ax(k).YLim = [1, 21];
  ax(k).YDir = 'normal';
  % if k <= 3
  %   ax(k).ZLim = [-4, 4];
  % else
  %   ax(k).ZLim = [-0.5, 1];
  % end
  ax(k).Title.String = sprintf('Time = %10.3f / %10.3f', jtime*dt, ntime*dt);
end