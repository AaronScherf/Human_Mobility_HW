
function [blobnumber,blobIsize,biggestblob,labeled] = CountBlobs(Pmat)

%Matlab function bwlabel(BW,4) returns the label matrix L that contains labels 
%for the 4-connected objects found in BW. 
%The label matrix, L, is the same size as BW.
%This function
labeled = bwlabel(Pmat,4);
blobnumber = 1:max(labeled(:));%Number of clusters
blobIsize = histc(labeled(:),blobnumber);%how many each label appears (cluster size)
[~,maxind] = max(blobIsize);
biggestblob = zeros(size(labeled));
biggestblob(labeled == maxind) = 1;
%blobsize = 1:100; %range of the histogram
%nsize = histc(blobIsize,blobsize); %check help matlab histc
end

