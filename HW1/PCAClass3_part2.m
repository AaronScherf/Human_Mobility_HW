%load realitymining.mat
%house 1, work 2, elsewhere 3, nosig  0, off NaN
% figure
 % colormap hot
 %colorbar
 % M=s(8).data_mat';
 %imagesc(M);
%% 
 %%%% Call Function
 %Mbw=generate_binary(M');
 %Mcolor=Mbw;
 %figure
 %colormap gray
 %imagesc(Mbw)
  %%
 [wcoeff,score,latent,tsquared,explained] = pca(Mbw);
 V=wcoeff;
 draw_eigbehav(V,1);
 draw_eigbehav(V,2);
 draw_eigbehav(V,3);
figure()
pareto(explained)

%%
figure()  
for i=1:3
      plot(M(i,:))
      hold all
  end    
  figure
   for i=1:3
      plot(wcoeff(:,i))
      hold all
   end
   xlabel('Time','FontSize',16);
   ylabel('Value','FontSize',16);
 

 