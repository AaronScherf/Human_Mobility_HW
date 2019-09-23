load TypicalWeekdayProfile.txt;
Mcolor=TypicalWeekdayProfile;
hours=size(Mcolor,2);
iter=size(Mcolor,1);
categories=cell(hours,1);
for j=1:hours
   categories{j}=sprintf('%dh',j);
end
%T=[];
 for i=1:size(Mcolor,1)
     plot((Mcolor(i,:)))
     hold all
     %T(i)=sum(Mcolor(i,:));
 end    
 
 

 