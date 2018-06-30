function code = train()
% non speech signal Recognition: Training Stage
%

% Output:
%       code     : trained VQ codebooks, code{i} for i-th class
%
% Example to run:
%       >> train();

k = 16;                         % number of centroids required
path = uigetdir;
myFiles = dir(fullfile(path,'*.wav')); %gets all wav files in struct

for i=1:length(myFiles)                       % train a VQ codebook for each class
    
    baseFileName = myFiles(i).name
    fullFileName = fullfile(path, baseFileName)
    fprintf(1, 'Now reading %s\n', fullFileName);
    [s, fs] = audioread(fullFileName);
    
    
    %[filepath,name,ext] = fileparts(fullFileName)
    %C = strsplit(name,'-')
    %label=C{4}
    %[s, fs] = audioread(file);
    
    v = mfcc(s, fs);            % Compute MFCC's
    
    code{i} = vqCodeBook(v, k);      % Train VQ codebook
    
end