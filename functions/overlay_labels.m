% Overlay Labels 
%
% PROGRAM DESCRIPTION
% This function overlays a previously plotted SOM image-based visualization 
% with the neurons' labels. 
%
% DATA & FUNCTION DICTIONARY
% Inputs: 
% sMap - SOM structure
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = overlay_labels(sMap) 
    P = prod(sMap.topol.msize);
    for j=1:P
        sub = som_ind2sub(sMap.topol.msize, j);
        Y = sub(1);
        X = sub(2);
        H = text(2*X-1, 2*Y-1, sMap.labels(j));
        H.Color = [1 0 0];
        H.FontWeight = 'bold';
        H.FontSize = 10;
    end
end
