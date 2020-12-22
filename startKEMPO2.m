close all;
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

number = 2;

% 以降数行はGUIに組み込む
% xyEorBplot = 0;
% kxkyPlot = 0;
% velocityDistPlot = 1;
EJplot = 0;
% wkxky = 1;
nkmax = 150; 
surfORimagesc = 1;
% 組み込みここまで

endTime = startTime + ntime;

if xyEorBplot
  v_xyEorB = VideoWriter(strcat(fileWithStartTime, '_xy_', num2str(endTime), '.mp4'), 'MPEG-4');
  % v_xyEorB.FrameRate = max(1, floor (ntime/ndskip/100));
  v_xyEorB.FrameRate = 3;
  open(v_xyEorB);
end
if kxkyPlot
  v_kxkyEorB = VideoWriter(strcat(fileWithStartTime, '_kxky_', num2str(endTime), '.mp4'), 'MPEG-4');
  % v_kxkyEorB.FrameRate = max(1, floor(ntime/ndskip/100));
  v_kxkyEorB.FrameRate = 3;
  open(v_kxkyEorB);
end
if velocityDistPlots
  v_velocitydist = VideoWriter(strcat(fileWithStartTime, '_velocitydist_', num2str(endTime), '.mp4'), 'MPEG-4');
  % v_velocitydist.FrameRate = max(1, floor(ntime/ndskip/100));
  v_velocitydist.FrameRate = 3;
  open(v_velocitydist);
end

num_v = 40;
dv = cv/num_v;
div = 2*[1:num_v+1]-1;
para = -1*cv:dv:cv;
perp = 0:dv:cv;
global zmax
zmax = zeros(1,ns);
% skipNumber = 4;
asterisk = '*';
cd(currentFolder);

kxkyt = zeros(nx, ny, ntime);

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
  if mod(itime, floor(ntime/10))==0
    disp(asterisk)
    asterisk = [asterisk, '*'];
  end
end

if wkxky
  % f_wkxky = figure(5);
  % f_wkxky.Position = [100, 100, 1000, 700];
  % 以降で時間方向にfft
  kxkyw = (abs(fft(kxkyt, ntime, 3))).^2;
  kxkyw = log10(kxkyw(1:(end/2)+1, 1:(end/2)+1, 1:size(kxkyw, 3)/2+1)); %ここでwの負の成分除去
  % disp(size(kxkyw))
  fig  = figure(100);
  fig.Name = 'Dispersion Relation';
  fig.Position = [100, 100, 800, 350];
  ax(1) = subplot(1,2,1); imagesc(squeeze(kxkyw(:,1,:))');colorbar;
  ax(1).YDir='normal'
  ax(1).Title.String = EBstring(number);
  ax(1).XLabel.String = 'kx';
  ax(1).YLabel.String = '\omega';
  ax(2) = subplot(1,2,2); imagesc(squeeze(kxkyw(1,:,:))');colorbar;
  ax(2).YDir='normal'
  ax(2).Title.String = EBstring(number);
  ax(2).XLabel.String = 'ky';
  ax(2).YLabel.String = '\omega';
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
if xyEorBplot
  close(v_xyEorB);
end
if kxkyPlot
  close(v_kxkyEorB);
end
if velocityDistPlots
  close(v_velocitydist);
end
toc;
cd(currentFolder);
% close all;