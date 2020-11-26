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

% dx = app.dx;
% dy = app.dy;
% dt = app.dt;
% nx = app.nx;
% ny = app.ny;
% ntime = app.ntime;
% wc = app.wc;
% theta = app.theta;
% phi = app.phi;
% cv = app.cv;
% ajamp = app.ajamp;
% omega = app.omega;

% ns = app.nsSpinner.Value;
% vPerp = zeros(ns);
% vPara = zeros(ns);

% for i = 1:ns
%     qm(i) = app.qm(i);
%     pch(i) = app.pch(i);
%     wp(i) = app.wp(i);
%     np(i) = app.np(i); 
%     vd(i) = app.vd(i);
%     vPerp(i) = app.vPerp(i);
%     vPara(i) = app.vPara(i);
% end

% vmax = app.vmaxEditField.Value;
% % bm = app.bmEditField.Value;
% zmax = app.zmaxEditField.Value;


% addpath('./params/');
% [filename, pathname] = uigetfile('./params/*.mat');
% load(filename);
% fileWithStartTime = strtok(filename, '.');
% fileOnlyAlphabet = strtok(filename, '_');
% endTime = startTime + ntime;

% addpath('./videos');
% cd videos
% if isfolder(fileOnlyAlphabet)==0
%   mkdir(fileOnlyAlphabet)
% end
% cd ..

vpe = [1,1];

vpa = [1,1];

tic;


v = VideoWriter(strcat(fileWithStartTime, '_', num2str(ntime), '.mp4'), 'MPEG-4');
v.FrameRate = 30;
open(v);

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
close(v);
toc;