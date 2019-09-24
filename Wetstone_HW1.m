%% CYPLAN 257: Homework 1
% Katie Wetstone
% Due 9/23/19
cd  '/Users/katewetstone/Desktop/CYPLAN 257 Data Science Human Mobility/DataHW1'

%% Problem 1
% 

%% Problem 1, Part (1)
% from simple_schedulePr1.m
clear
%%%%needed for biplot
categories = cell(24,1);
names = cell(4,1);

n = 1 : 24;
yw = 1+heaviside(n-9)-heaviside(n-17);
names{1}='home-work';

n = 1 : 24;
ynw = 1+2*heaviside(n-9)-2*heaviside(n-17);
names{2}='home-other';

n = 1 : 24;
yall = 1+heaviside(n-12)+1*heaviside(n-15)-2*heaviside(n-23);
names{3}='work-other';

n = 1 : 24;
yns = 1+heaviside(n-12)+2*heaviside(n-15);
names{4}='work-off';

days=4;
hours=24;

for j=1:hours
   Mcolor(1,j)=yw(j);
   categories{j}=sprintf('%dh',j);
end   
for j=1:hours
   Mcolor(2,j)=ynw(j);
end   
for j=1:hours
   Mcolor(3,j)=yall(j);
end   
for j=1:hours
   Mcolor(4,j)=yns(j);   
end

% Plot for part (1)
figure
 for i=1:size(Mcolor,1)
     plot(Mcolor(i,:),'o-')
     hold all
 end  
 legend('day 1','day 2','day 3','day 4')
 title('Problem 1.1')
 xlabel('Hour')
 ylabel('Value (location)')
 
%% Problem 1, Part (2)
[coeff,score,latent,tsquared,explained] = pca(Mcolor);
pareto(explained(1:3)) 
xlabel('Principal Component')
ylabel('Variance Explained (%)')
title('Problem 1.2 Pareto Histogram of the Variance Explained')

sum(explained(1:3)) % returns 100%

% The first three eigenvectors explain 100% of the variance

%% Problem 1, Part (3)
figure % projection onto first two PCs
sgtitle('Problem 1.3 Two-D Projections')
grid on
subplot(2,2,1)
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',categories,'MarkerSize',25);
grid on
xlabel('PC1')
ylabel('PC2')
subplot(2,2,2)
biplot(coeff(:,[1 3]),'scores',score(:,[1 3]),'varlabels',categories,'MarkerSize',25);
grid on
xlabel('PC1')
ylabel('PC3')
subplot(2,2,3)
biplot(coeff(:,2:3),'scores',score(:,2:3),'varlabels',categories,'MarkerSize',25);
grid on
xlabel('PC2')
ylabel('PC3')


figure % projection onto first three PCs
biplot(coeff(:,1:3),'scores',score(:,1:3),'varlabels',categories,'MarkerSize',20);
title('Problem 1.3 Three-D Projection')

% The projections are distinct from one another, but do not span a huge
% amount of the 3-D space of the first three principal components. In the
% biplot of the first two PCs the projections span about 135 degrees of the
% plot, showing that there is diversity but they are not hugely different.
% There is more variation in the 2D projection onto PCs 1 and 3, where the
% projections span more than 180 degrees of the space. They are the most
% similar in the 2D projections onto PCs 2 and 3. Most of the days fall
% into one quadrant of that two-dimensional space, and two of the largest
% exceptions (23h and 24h) are very similar to one another.

%% Problem 1, Part (4)
% plot the first three eigenvectors
 figure
  for i=1:size(coeff,2)
     plot(coeff(:,i))
     hold all 
  end
  xlabel('Time','FontSize',14);
  ylabel('Value','FontSize',14);
  legend('eigenvec 1','eigenvec 2','eigenvec 3')
  title('Problem 1.4 First 3 Eigenvectors','Fontsize',16)
  
%% Problem 1, Part (5)

% show original day 2 data
day = 2
Psi = mean(Mcolor,1);
vsample = Mcolor(day,:);
proj_2d = (vsample-Psi)*coeff;

% calculate reconstruction
rc = zeros(1,size(vsample,2));
sample=2;
proj_vec = []
for i = 1:sample
    proj=(vsample-Psi)*coeff(:,i);
    % The line below is PCA reconstruction = PCA scores * Eigenvectors^T + Mean
    rc =rc +proj*coeff(:,i)' % single quote transposes it
    proj_vec(i)=proj;
end
rc = rc+Psi;

% plot day 2 original data
y_min = min([min(rc) min(Mcolor(day,:))]);
y_max = max([max(rc) max(Mcolor(day,:))]);

figure
sgtitle('Problem 1.5')
subplot(2,1,1)
plot(Mcolor(day,:),'ro-')
ylim([y_min y_max]);
xlim([0 24]);
grid on
font_size=12;
title_x = ['Day 2 Original Data'];
title(title_x, 'FontSize', font_size)
xlabel('Hour', 'FontSize', font_size);
ylabel('Value', 'FontSize', font_size)

% plot reconstruction
subplot(2,1,2)
plot(rc,'o-')
ylim([y_min y_max]);
xlim([0 24]);
xlabel('Hour', 'FontSize', font_size);
ylabel('Value', 'FontSize', font_size)
title_x = ['Day 2 Reconstruction (2 PCs)'];
title(title_x, 'FontSize', font_size)
grid on

%%

%% Problem 2
%
clear
close all
% load data
load realitymining.mat
M=s(4).data_mat';
%%%% Call Function
Mbw = generate_binary(M');
[wcoeff,score,latent,tsquared,explained,mu] = pca(Mbw);

days = [10, 15, 20];

%% Problem 2, Part (1)

%Plot the days
for i=1:3
    dayn = days(i);
    
    figure
    full_title = ['Problem 2.1 Day ',num2str(dayn)];
    sgtitle(full_title)
    day = Mbw(dayn,:);
    ax1=subplot(3,2,1);
    plot(day(1:24),'ro-')
    grid on
    title_name = ['Home'];
    title(title_name)

    ax2=subplot(3,2,2);
    plot(day(25:48),'ro-')
    grid on
    title_name = ['Work'];
    title(title_name)

    ax3=subplot(3,2,3);
    plot(day(49:72),'ro-')
    grid on
    title_name = ['Elsewhere'];
    title(title_name)

    ax4=subplot(3,2,4);
    plot(day(73:96),'ro-')
    grid on
    title_name = ['No signal'];
    title(title_name)

    ax5=subplot(3,2,5);
    plot(day(97:120),'ro-')
    grid on
    title_name = ['Off'];
    title(title_name)
    %ylim([min(Day(:)),max(DAY(:))])
    linkaxes([ax1,ax2,ax3,ax4,ax5],'xy')
end
%%
% Plot the first three eigenvectors
for i=1:3
    figure
    full_title = ['Problem 2.1 Eigenvector ',num2str(i)];
    sgtitle(full_title)
    numb=i;
    ax1=subplot(3,2,1);
    plot(wcoeff(1:24,numb),'ko-') % telling it which column you want to plot?
    grid on
    title_name = ['Home'];
    title(title_name)

    ax2=subplot(3,2,2);
    plot(wcoeff(25:48,numb),'ko-')
    grid on
    title_name = ['Work'];
    title(title_name)

    ax3=subplot(3,2,3);
    plot(wcoeff(49:72,numb),'ko-')
    grid on
    title_name = ['Elsewhere'];
    title(title_name)

    ax4=subplot(3,2,4);
    plot(wcoeff(73:96,numb),'ko-')
    grid on
    title_name = ['No signal'];
    title(title_name)

    ax5=subplot(3,2,5);
    plot(wcoeff(97:120,numb),'ko-')
    grid on
    title_name = ['Off'];
    title(title_name)
    ylim([min(wcoeff(:,numb)),max(wcoeff(:,numb))])
    linkaxes([ax1,ax2,ax3,ax4,ax5],'xy')
end

% Comments
% Day 10
% * Basically same as Day 15
% * Home and work are both the negative of eigenvectors 1 and 2. No exceptions. Exactly 1 and 2. 
% * Then why are eigens 1 and 2 the same behavior?
% * More like Eigen 1 than Eigen 2, b/c elsewhere and no signal are zero
% Day 15
% * Home and work correspond to the the negative of eigenvector 1 and eigenvector 2.
% * Elsewhere corresponds more to eigenvector 3 (negative)
% * Only exception is hours ~17 and ~22-23
% * More like Eigen 2, because elsewhere and no signal are nonzero
% Day 20
% * Closest to eigenvector 3 because of the elsewhere values. Sort of?
% * No signal doesn?t really correspond to any , but there is a tiny bump in no signal at those times in Eigen 2
% * Eigen 3 does appear to have a break in the values of off around the right time (~11 or 12) in the correct direction
% * Doesn?t correspond that well to any of them.

%%
% project days 10, 15, and 20 on PC 1-3
figure % projection onto first three PCs
daylabels = {'Day 10','Day 15','Day 20'};
biplot(wcoeff(days,1:3),'VarLabels',daylabels,'MarkerSize',20);
title('Problem 2.1 Projection onto first 3 PCs')

wcoeff(days, 1:3)
% note that in the biplot, it is -1*the values in wcoeff

% Day 10 is explained twice as much by PC1 as by PC2 (both 
% positive, 0.02 and 0.04), but primarily explained by PC3 (0.09)

% Day 15 is not explained well by any of the three first PCs. Its
% coefficient is less than 0.004 (abs) for all three of them.

% Day 20 is explained mostly by PC3 (-0.06), and then by PC1 (0.015).
% It is explained a very small amount by PC2 (-0.0035).

% The largest coefficient in the first PC are Day 10 and Day 20, which
% both have positive coefficients in that direction. The second PC has
% the largest coefficient in day 10, which is positive, but that
% coefficient is still fairly small. Day 20 has a negative coefficient
% for PC2 but it is very small.
% The third PC has the largest coefficient in day 10, which has a 
% positive coefficient, followed by day 20, which has a negative 
% coefficient.

%% Problem 2, Part (2)

figure
sgtitle('Problem 2.2 Reconstruction with 3 Eigenvectors');
for i = 1:3
    day = days(i);
    
    % plot original data
    subplot(3,2,i*2-1)
    plot(Mbw(day,:),'ro-')
    ylim([min(Mbw(day,:)) max(Mbw(day,:))]);
    xlim([0 24]);
    grid on
    font_size = 12;
    title_x = ['Original Data Day ', num2str(day)];
    title(title_x, 'FontSize', font_size)
    xlabel('Hour', 'FontSize', font_size);
    ylabel('Value', 'FontSize', font_size);

    % plot reconstruction
    subplot(3,2,i*2)
    Psi = mean(Mbw,1); % gives mean of each column (dimension)
    vsample = Mbw(day,:);
    rc=zeros(1,size(vsample,2));
    sample=3;
    proj_vec=[];
    for j = 1:sample
        proj=(vsample-Psi)*wcoeff(:,j);
        % The line below is PCA reconstruction = PCA scores * Eigenvectors^T + Mean
        rc =rc +proj*wcoeff(:,j)'; % single quote transposes it
        proj_vec(j)=proj;
    end
    rc = rc+Psi;
    % OTHER OPTION
%     rc = bsxfun(@plus,mu,score(:,1:sample) *wcoeff(:,1:sample)');
%     rc = rc(day,:);
    plot(rc,'o-')
    ylim([min(rc) max(rc)]);
    xlabel('Hour', 'FontSize', font_size);
    title_x = ['Reconstruction Day ', num2str(day)];
    title(title_x, 'FontSize', font_size)
    grid on
end

%% Problem 2, Part (3)
fprintf('The first three eigenvectors account for %.2f%%\nof the variance in the entire data\n',sum(explained(1:3))) % returns 53.8375

% Compute accuracy of 3 sample days based on number of eigenvectors
% reconstruct with specified number of eigenvectors
% compute the accuracy for each day
% err gives 1
eigens = 3;
min_acc = 0;
while min_acc < 75
    rec = bsxfun(@plus,mu,score(:,1:eigens) *wcoeff(:,1:eigens)');
    acc = [];
    for j=1:3
        day = days(j);
        err = norm(Mbw(day,:)-rec(day,:)) / norm(Mbw(day,:));
        acc(j) = 100*(1 - err);
    end
    min_acc = min(acc);
%     err = norm(Mbw(days,:)-rec(days,:)) / norm(Mbw(days,:));
% %     abs(Mbw(days,:) - rec(days,:));
% %     err = sum(err,'all') / sum(Mbw(days,:),'all');
%     acc = 100*(1 - err);
    fprintf('%.2f%% explained by %d PCs\n', min_acc, eigens)
    eigens = eigens + 1;
end
% FLAG: check with someone that 42 is right

rec = bsxfun(@plus,mu,score(:,1:42) *wcoeff(:,1:42)');
day = 20;
err = norm(Mbw(day,:)-rec(day,:)) / norm(Mbw(day,:));
acc = 100*(1 - err)

% graph days 10 15 and 20 for subject 4
figure
colormap hot
colorbar
imagesc(M(days,:));
% for how to show binary matrix look at class 9.09 slide 25


%% Problem 2, Part (4)
% FLAG: calculate by day using norm? or for each day, take the absolute
% value of the difference and divide it by the day's value?
% for now, do norm of the day

rec = bsxfun(@plus,mu,score(:,1:3) *wcoeff(:,1:3)');
err = [];

for i = 1:size(Mbw,1)
    err(i) = norm(Mbw(i,:)-rec(i,:)) / norm(Mbw(i,:));
end

[errval, index] = sort(err,'descend'); % sort descending
worst_idx = index(1:3);
best_idx = index(length(err)-2:length(err));
fprintf('The day worst reconstructed by 3 eigenbehaviors is day %d\n',index(1))
fprintf('The individual error of the this day was the greatest of all the days.\n')
fprintf('This result was validated by plotting the three days with the worst calculated\nreconstruction accuracy and the three days with the best reconstructions.\n')

% To double check that it worked correctly, plot 3 best and 3 worst
%% plot 3 worst
figure
sgtitle('Problem 2.4 Worst Reconstructions');
for i = 1:3
    day = worst_idx(i);
    
    % plot original data
    subplot(3,2,i*2-1)
    plot(Mbw(day,:),'ro-')
    ylim([min(Mbw(day,:)) max(Mbw(day,:))]);
    xlim([0 24]);
    grid on
    font_size = 12;
    title_x = ['Original Data Day ', num2str(day)];
    title(title_x, 'FontSize', font_size)
    xlabel('Hour', 'FontSize', font_size);
    ylabel('Value', 'FontSize', font_size);

    % plot reconstruction
    subplot(3,2,i*2)
    Psi = mean(Mbw,1); % gives mean of each column (dimension)
    vsample = Mbw(day,:);
    rc=zeros(1,size(vsample,2));
    sample=3;
    rc = bsxfun(@plus,mu,score(:,1:sample) *wcoeff(:,1:sample)');
    rc = rc(day,:);
    plot(rc,'o-')
    ylim([min(rc) max(rc)]);
    xlabel('Hour', 'FontSize', font_size);
    title_x = ['Reconstruction Day ', num2str(day)];
    title(title_x, 'FontSize', font_size)
    grid on
end
%% plot 3 best
figure
sgtitle('Problem 2.4 Best Reconstructions');
for i = 1:3
    day = best_idx(i);
    
    % plot original data
    subplot(3,2,i*2-1)
    plot(Mbw(day,:),'ro-')
    ylim([min(Mbw(day,:)) max(Mbw(day,:))]);
    xlim([0 24]);
    grid on
    font_size = 12;
    title_x = ['Original Data Day ', num2str(day)];
    title(title_x, 'FontSize', font_size)
    xlabel('Hour', 'FontSize', font_size);
    ylabel('Value', 'FontSize', font_size);

    % plot reconstruction
    subplot(3,2,i*2)
    Psi = mean(Mbw,1); % gives mean of each column (dimension)
    vsample = Mbw(day,:);
    rc=zeros(1,size(vsample,2));
    sample=3;
    rc = bsxfun(@plus,mu,score(:,1:sample) *wcoeff(:,1:sample)');
    rc = rc(day,:);
    plot(rc,'o-')
    ylim([min(rc) max(rc)]);
    xlabel('Hour', 'FontSize', font_size);
    title_x = ['Reconstruction Day ', num2str(day)];
    title(title_x, 'FontSize', font_size)
    grid on
end

%% Problem 2, Part (5)
figure
plot(score(:,1), score(:,2),'o')
xlabel('First PC Score')
ylabel('Second PC Score')
title('Problem 2.5 First PC vs. Second PC')

gname

%% Problem 2, Part (6)
[st2, index] = sort(tsquared,'descend'); % sort descending
extreme = index(1:5);
% Five days most distant to the mean:
extreme; % 8, 44, 114, 157, 163

% Plot the extreme days
figure
sgtitle('Problem 2.6 Days most distant to mean')
for i=1:length(extreme)
    subplot(3,2,i)
    day = extreme(i);
    plot(M(day,:),'o-')
    titletext = ['Day ',num2str(day)];
    title(titletext)
    xlabel('Hour')
    ylabel('Value')
    hold all
end


%%

%% Problem 3
%
clear
close all
% load data
load TypicalWeekdayProfile.txt;
Mcolor=TypicalWeekdayProfile;
hours=size(Mcolor,2);
iter=size(Mcolor,1);
categories=cell(hours,1); % blank cell of right size
for j=1:hours
   categories{j}=sprintf('%dh',j); %fill in categories
end
%T=[];
figure
 for i=1:size(Mcolor,1) % number of accounts
     plot((Mcolor(i,:)))
     hold all
     %T(i)=sum(Mcolor(i,:));
 end  
 title('Problem 3')

 
%% Problem 3, Part (1)
size(Mcolor); % dimension is 1255x96
fprintf('%d accounts are given.\n', size(Mcolor,2))
fprintf('The dimensions are %d by %d\n', size(Mcolor,1), size(Mcolor,2))

%% Problem 3, Part (2)
% do PCA
[coeff,score,latent,tsquared,explained,mu] = pca(Mcolor);
% create vector with hour
hours = 0:0.25:23.75;

% plot the first six eigenvectors
 figure
 subplot(1,2,1)
  for i=1:3
     plot(hours,coeff(:,i))
     hold all 
  end
  xlabel('Time (Hour)');
  ylabel('Value');
  legend('PC1','PC2','PC3')
  grid on
  xlim([0 24])
  
  subplot(1,2,2)
  for i=4:6
     plot(hours,coeff(:,i))
     hold all 
  end
  xlabel('Time (Hour)');
  ylabel('Value');
  legend('PC4','PC5','PC6')
  xlim([0 24])
  grid on
  sgtitle('Problem 3.2 First 6 Eigenvectors')
  
  %% Problem 3, Part (3)
 pct = 0;
 eigs = 1;
 while pct < 92
      pct = sum(explained(1:eigs));
      fprintf('%d eigenvectors explain %0.2f of the variance\n',eigs,pct)
      eigs = eigs + 1;
 end
 % Four eigenvectors are needed to explain at least 92% of the variance
 sum(explained(1:4))
 
 %% Problem 3, Part (4)
 
coefforth= inv(diag(std(Mcolor)))*coeff;
ColorMap = colormap;
ncolors = size(ColorMap,1);

R=[score(:,1),score(:,2),score(:,3),score(:,4),score(:,5),score(:,6)];
  K = 4;  % look for four clusters
  [ID2,ClusterCentroid2,SSE2] = kmeans(R,K,'start','cluster');
  SumSqErr2 = sum(SSE2)
  figure
  for id = 1:K
    textcolor(id,:) = ColorMap(1+round((ncolors-1)*(id-1)/(K-1)),:);  
    plot(R(ID2==id,1),R(ID2==id,2),'.','Color',textcolor(id,:),'MarkerSize',8)
    hold on
%     plot(ClusterCentroid2(id,1),ClusterCentroid2(id,2),'kx','MarkerSize',12)
%     hold on
  end
  for id=1:K
    plot(ClusterCentroid2(id,1),ClusterCentroid2(id,2),'kx','MarkerSize',12)
    hold on
  end
  xlabel('Score 1')
  ylabel('Score 2')
  title('Problem 3.4 Cluster Centroids')
  legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4')
  xlim([min(score(:,1)) max(score(:,1))])
  ylim([min(score(:,2)) max(score(:,2))])

figure
sgtitle('Problem 3.4')
id=1
subplot(2,2,id)
textcolor(id,:) = ColorMap(1+round((ncolors-1)*(id-1)/(K-1)),:);  
plot(R(ID2==id,1),R(ID2==id,2),'.','Color',textcolor(id,:),'MarkerSize',8)
hold on
plot(ClusterCentroid2(id,1),ClusterCentroid2(id,2),'kx','MarkerSize',12)
hold on
title('Cluster 1')

id=2
subplot(2,2,id)
textcolor(id,:) = ColorMap(1+round((ncolors-1)*(id-1)/(K-1)),:);  
plot(R(ID2==id,1),R(ID2==id,2),'.','Color',textcolor(id,:),'MarkerSize',8)
hold on
plot(ClusterCentroid2(id,1),ClusterCentroid2(id,2),'kx','MarkerSize',12)
hold on
title('Cluster 2')

id=3
subplot(2,2,id)
textcolor(id,:) = ColorMap(1+round((ncolors-1)*(id-1)/(K-1)),:);  
plot(R(ID2==id,1),R(ID2==id,2),'.','Color',textcolor(id,:),'MarkerSize',8)
hold on
plot(ClusterCentroid2(id,1),ClusterCentroid2(id,2),'kx','MarkerSize',12)
hold on
title('Cluster 3')

id=4
subplot(2,2,id)
textcolor(id,:) = ColorMap(1+round((ncolors-1)*(id-1)/(K-1)),:);  
plot(R(ID2==id,1),R(ID2==id,2),'.','Color',textcolor(id,:),'MarkerSize',8)
hold on
plot(ClusterCentroid2(id,1),ClusterCentroid2(id,2),'kx','MarkerSize',12)
hold on
title('Cluster 4')

%% Problem 3, Part (5)
%  FLAG: how do you want us to plot the data?
figure
sgtitle('Problem 3.5')
for i=1:K
    subplot(2,2,i)
    cluster=Mcolor(ID2==i,:);
    for j=1:size(cluster,1)
        plot(hours,cluster(j,:))
        hold all
    end
    xlim([0 24])
%     ylim([minmin((Mcolor))
    xlabel('Hour')
    ylabel('Value')
    titlex = ['Cluster ',num2str(i)];
    title(titlex)
end

% Cluster 1 overall strongly resembles the shape of PC1, with high peaks 
% around 11 hours and 16 hours. This is also reflected in that most of
% cluster 1 has negative scores for PC2, making the peaks at ~11 and 16
% more pronounced.

% Cluster 3 has the most diversity of any of the clusters in the scores for
% PC1 and PC2. It also has the largest score for PC1.

% Cluster 4 is the most compact in terms of scores for PC1 and PC2. 

% The clusters divided almost entirely along the lines of their scores for
% PC1, implying that PC1 accounts for a large percentage of the variance
% and therefore the clustering. This is corroborated by the fact that
% explained(1) = 73.87, so PC1 accounts for 73.87% of the total variance in
% the data.
