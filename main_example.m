% This is an example of IT-vis generation. 
%
% PROGRAM DESCRIPTION
% This program exemplifies the usage of the IT-vis code provided.
%
% REFERENCES:
% [1] “SOM IT-vis.” [Online]. Available: https://git.mst.edu/acil-group/som-it-vis
% [2] Leonardo Enzo Brito da Silva and Donald C. Wunsch II, “An Information-Theoretic-
% Cluster Visualization for Self-Organizing Maps,” submitted for publication.
% [3] J. Vesanto, J. Himberg, E. Alhoniemi, and J. Parhankangas, “Self-Organizing Map in 
% Matlab: the SOM Toolbox,” in Proceedings of the Matlab DSP Conference, 1999, pp. 35–40.
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clean Run
clc
clear 
close all
echo off

%% set current directory and add directories to path
cd(fileparts(mfilename('fullpath')))
addpath('functions');

%% Load Fisher's Iris Data from wihin Matlab 
load fisheriris.mat

%% Training SOM using SOMToolbox©
data = som_normalize(meas, 'range');
msize = [8 8];
dim = size(data, 2);
sData = som_data_struct(data, 'labels', species);
sMap = som_map_struct(dim,'mask', ones(1, dim),...
                           'msize', msize,...
                           'lattice', 'rect',...
                           'shape', 'sheet',...
                           'neigh', 'gaussian');
sMap = som_lininit(data, sMap);
sMap = som_batchtrain(sMap, data, 'trainlen', 3e3); 
sMap = som_autolabel(sMap, sData, 'vote');

%% IT-vis matrix
ITvis = 'rH*';  % rH*-vis
mode = 'MOD';   % Modified k-NN
MinPts = 26;    % MinPts
conn = 4;       % 4-neighborhood connectivity
M = SOM_ITvis(sMap, data, ITvis, mode, MinPts, conn);

%% Visualization
view_type = 'heatmap';
visualize(ITvis, view_type, M)
overlay_labels(sMap) 

%% End
display('Thats all folks!')