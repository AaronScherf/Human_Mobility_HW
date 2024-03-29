cd 'C:\Users\theaa\Desktop\Data Science Pedagogy Resources\Matlab\Human Mobility\DataHW1\Human_Mobility_HW\HW1';

% Problem 1: Basics of PCA
% 1) Use the script simple_schedulePr1.m and plot each day of data of a
% simple schedule of 4 days, each integer represents a location ID (1pt)

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
 title('Problem 1, Part 1')
 xlabel('Hour')
 ylabel('Value (location)')
 

%%
% 2) Calculate the PCA on this Matrix and plot the pareto histogram of the
% variance explained. How much variance the first three eigenvectors explain? (1pt)

[coeff,score,latent,tsquared,explained] = pca(Mcolor);
pareto(explained(1:3)) 
xlabel('Principal Component')
ylabel('Variance Explained (%)')
title('Pareto Histogram of the Variance Explained')

sum(explained(1:3))


%%
% 3) Plot the biplots of the scores and component projections of the data.

figure % projection onto first two PCs
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',categories,'MarkerSize',25);
title('Projection onto first two principal components')
figure % projection onto first three PCs
biplot(coeff(:,1:3),'scores',score(:,1:3),'varlabels',categories,'MarkerSize',20);
title('Projection onto first three principal components')


% Do they have similar projections? (1pt)

%%
%4) Plot the 3 first eigenvectors (1pt)
 figure
  for i=1:size(coeff,2)
     plot(coeff(:,i))
     hold all 
  end
  xlabel('Time','FontSize',16);
  ylabel('Value','FontSize',16);
  legend('eigenvec 1','eigenvec 2','eigenvec 3')
  
 %% 
% 5) Reconstruct day 2 with the first 2 eigenvectors, show data vs. reconstruction (1pt)


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
subplot(1,2,1)
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
subplot(1,2,2)
plot(rc,'o-')
ylim([y_min y_max]);
xlim([0 24]);
xlabel('Hour', 'FontSize', font_size);
ylabel('Value', 'FontSize', font_size)
title_x = ['Day 2 Reconstruction (2 PCs)'];
title(title_x, 'FontSize', font_size)
grid on

%%
% Problem 2: Eigenbehaviors 
% Use the activity matrix of subject 4, and answer the following questions:

clear
close all
% load data
load realitymining.mat
M=s(4).data_mat';
%%%% Call Function
Mbw = generate_binary(M');
[wcoeff,score,latent,tsquared,explained,mu] = pca(Mbw);

days = [10, 15, 20];


% How the first 3 eigenvectors for the chosen subject relate to the
% behaviors seen in days 10, 15 and 20 of this subject. Do the projections
% to answer this question. (2 pts)


%Plot the days
for i=1:3
    dayn = days(i);
    
    figure
    full_title = ['Values Day ',num2str(dayn)];
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
    full_title = ['Eigenvector ',num2str(i)];
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


% Draw the reconstruction of these three sample days with the first three
% eigenvectors. (2 pts)

% project days 10, 15, and 20 on PC 1-3
figure % projection onto first three PCs
daylabels = {'Day 10','Day 15','Day 20'};
biplot(wcoeff(days,1:3),'VarLabels',daylabels,'MarkerSize',20);
title('Projection onto first three principal components')

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

%%
% What percentage of the variance of the entire data the first 3
% eigenvectors account for? How many eigenvectors do you need to
% reconstruct each of the 3 sample days with more than 75% accuracy? (3pts)


figure
sgtitle('Data reconstruction with 3 eigenvectors');
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


%%
% Can you identify a day that is the worst reconstructed by the first 3
%eigenbehaviors? justify your answer (3 pts)

% Plot the First vs. the Second PCA and mark few days using gname (3pts)
% Based on the Tsquared what are the 5 days most distant to the mean?


% Plot them as the value of the component vs. time. (2 pts)
% Note: Use the data files realitymining.mat Let me know if this file is too
% large to be handled by your computer.


% Upload the matlab script that produces each answer
% Upload the the answers to each question in a pdf file: I will evaluate the
% written solutions and check the code for reference.


% Problem 3: Clustering Electric Consumption with PCA
% Use the data read and provided in the script pca_electricHW.m

% It has the average reads of energy consumption in kilowatts [KW]each 15
% minutes interval during one day for several accounts.

%1) How many accounts are given? and What is the dimension of the data? (1pt)

% 2) Plot the first 6 eigenvectors, convert the x axis in a range from 1 to 24 (1pt)

% 3) How many K eigenvectors are needed to explain at least 92% of the variance?


% 4)Use that number to apply Kmeans with K equal to the answer above,
% show the clusters given by the method and their centroids


% 5)Plot the data of the original accounts separated in K subplots. What
% can you learn from the accounts that belong to each of the K clusters.
