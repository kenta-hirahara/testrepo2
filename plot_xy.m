function plot_xy(xyEB, map, k, EBstring, jtime, ntime ,dt)
  ax(k) = subplot(2, 3, k);imagesc(cell2mat(xyEB(k))');
  colormap(map);  colorbar; shading flat;
  % switch k 
  % case {1,2,3}
  %   caxis([-4, -1]);
  % case {4,5,6}
  %   caxis([-5, -2]);
  % end

  ax(k).DataAspectRatio = [100, 100, 1];
  ax(k).XLabel.String = 'X'; ax(k).YLabel.String = 'Y'; ax(k).ZLabel.String = cell2mat(EBstring(k));
  ax(k).YDir = 'normal';
  ax(k).Title.String = sprintf('%s \n Time = %10.3f / %10.3f', cell2mat(EBstring(k)), jtime*dt, ntime*dt);
end
