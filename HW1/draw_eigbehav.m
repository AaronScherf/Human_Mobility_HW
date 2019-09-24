function draw_eigbehav(V,eig_index)


num_labels = 5;
hours=24;

house_i=1;
work_i=2;
elsewhere_i=3;
nosig=4;



figure;
colormap hot;
Ji=hours*(house_i-1)+1;
Jf=hours*house_i;
subplot(4,1,1)
imagesc(V(Ji:Jf,eig_index)')
title('Home','FontSize',16)
caxis([-0.05 0.15])
colorbar;

%figure;
colormap hot;
Ji=hours*(work_i-1)+1;
Jf=hours*work_i;
subplot(4,1,2)
imagesc(V(Ji:Jf,eig_index)')
colorbar;
caxis([-0.05 0.15])
title('Work','FontSize',16)

%figure;
colormap hot;
Ji=hours*(elsewhere_i-1)+1;
Jf=hours*elsewhere_i;
subplot(4,1,3)
imagesc(V(Ji:Jf,eig_index)')
colorbar;
caxis([-0.05 0.15])
title('Elsewhere','FontSize',16)

%figure;
colormap hot;
Ji=hours*(nosig-1)+1;
Jf=hours*nosig;
subplot(4,1,4)
imagesc(V(Ji:Jf,eig_index)')
title('NoSig','FontSize',16)
caxis([-0.05 0.15])
colorbar;