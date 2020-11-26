if(jobnumber == 1) 
  renormalization;
  initial;
  position; 
  charge;
  potential;
  energy;
end
            
v_xyEorB = VideoWriter(strcat(fileWithStartTime, '_xy_', num2str(endTime), '.mp4'), 'MPEG-4');
v_xyEorB.FrameRate = 50;
open(v_xyEorB);

v_kxkyEorB = VideoWriter(strcat(fileWithStartTime, '_kxky_', num2str(endTime), '.mp4'), 'MPEG-4');
v_kxkyEorB.FrameRate = 50;
open(v_kxkyEorB);

v_velocitydist = VideoWriter(strcat(fileWithStartTime, '_velocitydist_', num2str(endTime), '.mp4'), 'MPEG-4');
v_velocitydist.FrameRate = 50;
open(v_velocitydist);

for itime = 1:ntime
  jtime = jtime +1;
  bfield;
  rvelocity;
  position;
  current;
  position;
  bfield;
  efield;
  charge;
  potential;
  diagnostics;
end

jobnumber = jobnumber + 1;
startTime = endTime;
cd('./params')
save(strcat(fileOnlyAlphabet, '_', num2str(endTime)));
close(v_xyEorB);
close(v_kxkyEorB);
toc;
cd ..