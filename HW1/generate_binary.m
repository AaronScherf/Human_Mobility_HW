function [Mbw] = generate_binary2(M)
hours=size(M,1);
days=size(M,2);
num_labels=5;
Mbw = zeros(days,num_labels*hours);
categories = cell(num_labels*hours,1);
for i = 1:num_labels*hours
   categories{i}='err';    
end    
for i = 1:days
       for j = 1:hours
          place=M(j,i);
          if(isnan(place))
             Ji=hours*(num_labels-1)+1; %97=24*(5-1)+1
             Jf=hours*num_labels; %120
             J=Ji+j-1;
             Mbw(i,J)=1;
             categories{J}='off';
          else
             if(place==0)
                Ji=hours*(num_labels-2)+1; %73
                Jf=hours*(num_labels-1); %96
                J=Ji+j-1;
                Mbw(i,J)=1;
                categories{J}='ns';
             else
                Ji=hours*(place-1)+1; % (1-24) for house and (25-48) for work 
                Jf=hours*place;       % and (49-72) for elsewehere
                J=Ji+j-1;
                Mbw(i,J)=1;
                if(place==1) categories{J}='h'; end
                if(place==2) categories{J}='w'; end
                if(place==3) categories{J}='o'; end
             end
          end
       end
end