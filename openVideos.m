if check.xyPlot
  xyExyBvideoFileName = strcat(fileWithoutDotM, '_xy_', num2str(endTime), '_', startSimulationDatetime, '.mp4');
  v_xyEorB = VideoWriter(xyExyBvideoFileName, 'MPEG-4');
  v_xyEorB.FrameRate = max(1, floor (ntime/ndskip/100));
  % v_xyEorB.FrameRate = 30;
  open(v_xyEorB);
end
if check.kxkyPlot
  kxkyEorBvideoFileName = strcat(fileWithoutDotM, '_kxky_', num2str(endTime), '_', startSimulationDatetime, '.mp4');
  v_kxkyEorB = VideoWriter(kxkyEorBvideoFileName, 'MPEG-4');
  v_kxkyEorB.FrameRate = max(1, floor(ntime/ndskip/100));
  % v_kxkyEorB.FrameRate = 30;
  open(v_kxkyEorB);
end
if check.veloDistPlot
  velocitydistVideoFileName = strcat(fileWithoutDotM, '_velocitydist_', num2str(endTime), '_', startSimulationDatetime, '.mp4');
  v_velocitydist = VideoWriter(velocitydistVideoFileName, 'MPEG-4');
  v_velocitydist.FrameRate = max(1, floor(ntime/ndskip/100));
  % v_velocitydist.FrameRate = 30;
  open(v_velocitydist);
end
if check.EJ
  EJvideoFileName = strcat(fileWithoutDotM, '_EJ_', num2str(endTime), '_', startSimulationDatetime, '.mp4');
  v_EJ = VideoWriter(EJvideoFileName, 'MPEG-4');
  v_EJ.FrameRate = max(1, floor (ntime/ndskip/100));
  % v_EJ.FrameRate = 30;
  open(v_EJ);
end