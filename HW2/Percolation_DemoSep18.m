
% Generate matrix of random values between 0 and 1
randmat = rand(10,10,'single');
threshold = 0.3; % SET INITIAL THRESHOLD VALUE HERE
mat = randmat; %No correlation
biggestblob = 0; % No value for largest connected region (yet)

%% Step 1 visualize original matrix
step_one = figure('Name','Step One'); %Random Matrix
imagesc(mat)
colormap('jet')
colorbar

%% Step 2 see percolation matrix
step_two = figure('Name','Step Two'); %Binary Matrix
Pmat=mat<threshold;
imagesc(Pmat)
colormap('gray')
colorbar

%% Label Cluster and see Labeled Matrix
%%Different colors refer to different labels
[blobnumber,blobIsize,biggestblob,labeled]=CountBlobs(Pmat) %%%here the output of the script

step_three = figure('Name','Step Three'); % Labeled Binary Matrix
imagesc(labeled)
colorbar
colormap('jet')

%each label corrresponds to a different cluster id
labeled

%We see here the biggestblob only
biggestblob
%%
%%Use Red Blue White to paint: Largest, Occupied and Empty
step_four = figure('Name','Step Four'); % Pick Out Largest Region
plotim = (Pmat)+ 2*biggestblob+2; %three colors 2 (empty), 3 (occupied) and 5 (biggest cluster)
stepfourplot = image(plotim);
colormap('flag')
hh = colorbar();
set(hh,'YLim',[0.5,3.5])
set(hh,'YTick',[1,2,3])
set(hh,'YTickLabel',{'Largest','Empty','Occupied'})

%array with all cluster sizes
blobIsize

%this gives the size of the largest cluster
max(blobIsize)






