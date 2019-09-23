


%% Set expected constants (see D. Stauffer, Introduction to Percolation Theory)
p_c = 0.5927;
tau = 187/91;

%% Set size parameters
nsamples = 10;
matrixsize = 500;
nump = 100;
%% Create arrays to fill
p = linspace(0.05,p_c+0.1,nump);
values = zeros(matrixsize*10,nump); %adds the histograms of cluster sizes for each p 
blobsize = 1:matrixsize*10; % Bins for region size histogram
biggestblobs = zeros(nump,nsamples); %saves for each p and sample size of largest cluster

%%Find in the array p the closest to pc
[minValue,closestIndex] = min(abs(p-p_c))
p(closestIndex)


%% Calculate size statistics for various values of p and various random matrix seeds

for jj = 1:nsamples % loop over random matrices
    randmat = rand(matrixsize,matrixsize,'single');
    disp(jj)
    for ii = 1:nump % loop over values for p
        [blobnumber,blobIsize,biggestblob,labeled]=CountBlobs( randmat < p(ii));
        nsize = histc(blobIsize,blobsize); %histogram of clustersizes
        values(:,ii) = values(:,ii) + nsize/nsamples;
        biggestblobs(ii,jj) = nnz(biggestblob);
    end
end
%% Display results

%scrsz = get(groot,'ScreenSize');
%figure('Position',[100 100 scrsz(3)/1.25 scrsz(4)/1.5])

subplot(1,2,1)
mean_biggest = mean(biggestblobs,2);
plot(p,mean_biggest,'ro')
hold on
set(gca,'YScale','log')
xlabel('p')
ylabel('s_{max}')
set(gcf, 'Color', 'w')


subplot(1,2,2)
loglog(blobsize,(values(:,closestIndex)),'bo')
set(gca,'YScale','log')
xlabel('Connected Region Size s (pixels)')
ylabel('Number of regions, n_s')
