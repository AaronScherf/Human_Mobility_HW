clear
%%%%needed for biplot
categories = cell(24,1);
names = cell(4,1);

n = 1 : 24;
yw = 1+heaviside(n-9)-heaviside(n-17);
names{1}='home-work';
%stem(n, yw);

%figure()
n = 1 : 24;
ynw = 1+2*heaviside(n-9)-2*heaviside(n-17);
names{2}='home-other';
%stem(n, ynw);

%figure()
n = 1 : 24;
yall = 1+heaviside(n-12)+1*heaviside(n-15)-2*heaviside(n-23);
names{3}='work-other';
%stem(n, yall);

%figure()
n = 1 : 24;
yns = 1+heaviside(n-12)+2*heaviside(n-15);
names{4}='work-off';
%stem(n, yns);

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

%%
[coeff,score,latent,tsquared,explained] = pca(Mcolor);
pareto(explained(1:3))
xlabel('Principal Component')
ylabel('Variance Explained (%)')
figure
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',categories,'MarkerSize',25);
 figure
 biplot(coeff(:,1:3),'scores',score(:,1:3),'varlabels',categories,'MarkerSize',20);
 %%
 figure
 for i=1:size(Mcolor,1)
     plot(Mcolor(i,:),'o-')
     hold all
 end  
 legend('day 1','day 2','day 3','day 4')
 figure
  for i=1:size(coeff,2)
     plot(coeff(:,i))
     hold all
  end
  xlabel('Time','FontSize',16);
  ylabel('Value','FontSize',16);
  legend('eigenvec 1','eigenvec 2','eigenvec 3')
 
