% vpPara = vx + cv;
% vpPerp = sqrt(vy.*vy + vz.*vz);
% num_v  = 100;
dv = cv / num_v;

h = histogram2(vx, sqrt(vy.*vy + vz.*vz));
h.XBinLimits = [-1*cv, cv];
h.YBinLimits = [0, cv];
h.NumBins = [2*num_v, num_v];

editableHistgram = h.Values;

editableHistgram = editableHistgram ./ [1:num_v];

im = image(editableHistgram);
im.Parent = 
im.CDataMapping = 'scaled';