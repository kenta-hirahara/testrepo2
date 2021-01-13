close all; clc;
addpath('./pastJobs');

courantAlert;
loadApp;

currentFolder = pwd;
startSimulationDatetime = char(datetime('now','Format','yyyy-MM-dd''T''HHmmss'));
cd('./pastJobs');
mkdir(startSimulationDatetime);
newDirAbsolutePath = [currentFolder '/pastJobs/' startSimulationDatetime];
addpath(newDirAbsolutePath);
cd(currentFolder);

disp('Simulation started'); 
addpath('./colormap');
map = colormapTurbo;
mapEJ = colormapRdYlBu;
% GUIから実行する場合はこれ以降5行をコメントアウト
% addpath('./params/');
% [filename,path] = uigetfile('./params/*.mat');
% load(filename);
% fileWithoutDotM = strtok(filename, '.');
% fileOnlyAlphabet = strtok(filename, '_');

if(jobnumber == 1) 
  renormalization;
  initialization;
  position; 
  charge;
  potential;
  energy;
end  

nkmax = 50; 
surfORimagesc = 1;

endTime = startTime + ntime;

openVideos;

num_v = 40;
dv = cv/num_v;
div = 2*[1:num_v+1]-1;
para = [-1*cv:dv:cv]*rnv;
perp = [0:dv:cv]*rnv;
global zmax
zmax = zeros(1,ns);
% skipNumber = 4;
asterisk = '*';
parameterFileForContiniusJob = ['_jobnum' num2str(jobnumber) '_' startSimulationDatetime '.mat'];
paramEJ.spName = {'All Species', 'Species 1', 'Species 2', 'Species 3', 'Species 4'};
paramEJ.direction = {'Parallel', 'Perpendicular', 'All directions'};
if check.wkxky
  divide_k = 2;
  dispFilename = ['dispersionData' cell2mat(app.EBstring(app.EBnumber)) '.mat'];
  dataHDD = matfile(dispFilename, 'Writable',true);
  dataHDD.kxkyt = zeros(nx/divide_k+1, ny*2/divide_k, ntime);
end
% figNumber = 1;
tic;  
for itime = 1:ntime
  jtime = jtime +1;
  bfield;
  rvelocity;
  position;
  current;
  if check.EJ
    calcEJ;
  end
  position;
  bfield;
  efield;
  charge;
  potential;
  diagnostics;
  if mod(itime, floor(ntime/10))==0
    disp(asterisk)
    asterisk = [asterisk, '*'];
    if size(asterisk, 2)==6
      asterisk = '*';
    end
  end
end

if check.wkxky
  % save('kxkyt.mat', 'kxkyt', '-v7.3');
  movefile(dispFilename, newDirAbsolutePath);
  disp('Culculating For Dispersion Plot');
  dispersionPlot;
end

jobnumber = jobnumber + 1;
startTime = endTime;

closeVideos;
moveVideos;
toc;

clear app event im fig ax v_velocitydist f_velocitydist ignoreAxis;
save(parameterFileForContiniusJob, '-v7.3');


movefile(parameterFileForContiniusJob, newDirAbsolutePath);

disp('Successfully Finished. Files are stored to:');
disp(newDirAbsolutePath);