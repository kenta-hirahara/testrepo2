filename = '_whistler_0_xy_32768.mp4'
v = VideoReader(filename);
new_v = VideoWriter(['80frameRate', filename], 'MPEG-4');
new_v.FrameRate = 80;
open(new_v);
while hasFrame(v)
  frame = readFrame(v);
  writeVideo(new_v, frame);
end
close(new_v);