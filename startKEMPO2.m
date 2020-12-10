currentFolder = pwd;

% GUIから実行する場合はこれ以降5行をコメントアウト

% addpath('./params/');
% [filename,path] = uigetfile('./params/*.mat');
% load(filename);
% fileWithStartTime = strtok(filename, '.');
% fileOnlyAlphabet = strtok(filename, '_');

if(jobnumber == 1) 
  renormalization;
  initial;
  position; 
  charge;
  potential;
  energy;
end  

EBstring = {'Ex', 'Ey', 'Ez', 'Bx', 'By', 'Bz'};
xyEorBplot = 0;
kxkyPlot = 1;
velocityDistPlot = 0;
EJplot = 1;

endTime = startTime + ntime;

v_xyEorB = VideoWriter(strcat(fileWithStartTime, '_xy_', num2str(endTime), '.mp4'), 'MPEG-4');
v_xyEorB.FrameRate = max(1, floor(ntime/ndskip/100));
open(v_xyEorB);

v_kxkyEorB = VideoWriter(strcat(fileWithStartTime, '_kxky_', num2str(endTime), '.mp4'), 'MPEG-4');
v_kxkyEorB.FrameRate = max(1, floor(ntime/ndskip/100));
open(v_kxkyEorB);

v_velocitydist = VideoWriter(strcat(fileWithStartTime, '_velocitydist_', num2str(endTime), '.mp4'), 'MPEG-4');
v_velocitydist.FrameRate = max(1, floor(ntime/ndskip/100));
open(v_velocitydist);

num_v = 40;
dv = cv/num_v;
div = 2*[1:num_v+1]-1;
para = -1*cv:dv:cv;
perp = 0:dv:cv;
zmax = zeros(1,ns);
% skipNumber = 4;

cd(currentFolder);
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
  diagnostics;
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
% close(v_kxkyEorB);
close(v_velocitydist);
toc;
cd(currentFolder);