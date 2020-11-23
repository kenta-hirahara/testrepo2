%****************************************************************
%
%  KEMPO2
%    Kyoto university ElectroMagnetic Particle cOde: 2D version
%
%     programed by Yoshharu Omura   September 1, 2018
%     Research Institute for Sustainable Humanosphere
%     Kyoto University
%     Gokasho, Uji, Kyoto 611-0011, Japan
%     omura@rish.kyoto-u.ac.jp
%
%          Copyright(c) 1993-2018, Space Simulation Group,
%          RISH, Kyoto University, All rights reserved.
%
%          Version 1.3   September 1, 2018
%
%****************************************************************
%  For charge conservation method:  Use current2
%             comment out  charge and potential in the main loop

clear all; clf;
colormap jet;

% これはGUI無い時に使用するコードなので、パラメータのロード関数が入っている
addpath('./params/');
[filename, pathname] = uigetfile('./params/*.mat');
load(filename);
fileWithStartTime = strtok(filename, '.');
fileOnlyAlphabet = strtok(filename, '_');
endTime = startTime + ntime;

% videoディレクトリのなかにファイル名のディレクトリを作る
% addpath('./videos');
% cd videos
% if isfolder(fileOnlyAlphabet)==0
%   mkdir(fileOnlyAlphabet)
% end
% cd ..

tic;
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