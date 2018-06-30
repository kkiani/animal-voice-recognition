function test( code)
% non speech signal Recognition: Testing Stage
%
% Input:
%       
%       code    : codebooks of all trained classes
%

% Example:
%       >> test(code);
disp('fap')
path = uigetdir;
myFiles = dir(fullfile(path,'*.wav')); %gets all wav files in struct

for k=1:length(myFiles)                       % read test sound file of each class
    
    disp('fap')
    baseFileName = myFiles(k).name
    fullFileName = fullfile(path, baseFileName)
    disp(fullFileName)
    [s, fs] = audioread(fullFileName);
    v = mfcc(s, fs);            % Compute MFCC's
   
    distmin = inf;
    k1 = 1;
   
    for l = 1:length(code)      % each trained codebook, compute distortion
        d = distance(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);
      
        if dist < distmin
            distmin = dist;
            k1 = l;
        end      
        
    end
   
    msg = sprintf('Voice %d matches with class %d', k, k1);
    disp(msg);
end