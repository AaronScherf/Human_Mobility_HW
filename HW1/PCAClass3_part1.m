load realitymining.mat
%house 1, work 2, elsewhere 3, nosig  0, off NaN
 figure
  colormap hot
 colorbar
  M=s(8).data_mat';
 imagesc(M);
%% 
 %%%% Call Function
 Mbw=generate_binary(M');
 Mcolor=Mbw;
 figure
 colormap gray
 imagesc(Mbw)
 