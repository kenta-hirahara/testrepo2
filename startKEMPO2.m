currentFolder = pwd;

addpath('./params/');
[filename,path] = uigetfile('./params/*.mat');
load(filename);

if(jobnumber == 1) 
  renormalization;
  initial;
  position; 
  charge;
  potential;
  energy;
end

% if app.videoPathSpecified == 1
%   cd(app.saveVideoFile)
% else
%   cd(currentFolder)
% end
    %  fileWithStartTime = 'shNgi_0';       
fileWithStartTime = strtok(filename, '.');
fileOnlyAlphabet = strtok(filename, '_');
endTime = startTime + ntime;

v_xyEorB = VideoWriter(strcat(fileWithStartTime, '_xy_', num2str(endTime), '.mp4'), 'MPEG-4');
v_xyEorB.FrameRate = 30;
open(v_xyEorB);

v_kxkyEorB = VideoWriter(strcat(fileWithStartTime, '_kxky_', num2str(endTime), '.mp4'), 'MPEG-4');
v_kxkyEorB.FrameRate = 30;
open(v_kxkyEorB);

v_velocitydist = VideoWriter(strcat(fileWithStartTime, '_velocitydist_', num2str(endTime), '.mp4'), 'MPEG-4');
v_velocitydist.FrameRate = 30;
open(v_velocitydist);

cd(currentFolder)
tic;  
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
  diagnos;
end

jobnumber = jobnumber + 1;
startTime = endTime;
% cd('./params')
% save(strcat(fileOnlyAlphabet, '_', num2str(endTime)));
% if app.videoPathSpecified == 1
%   cd(app.saveVideoFile)
% else
%   cd(currentFolder)
% end
close(v_xyEorB);
close(v_kxkyEorB);
close(v_velocitydist);
toc;
cd(currentFolder)

