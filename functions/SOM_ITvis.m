% Generate SOM IT-vis
%
% PROGRAM DESCRIPTION
% This function generates SOM IT-vis (heatmap).
%
% DATA & FUNCTION DICTIONARY
% Inputs: 
% sMap - SOM structure
% data - data matrix
% IT-vis - string indicating the type of IT-vis ('CIP', 'H*', 'rCIP', 'rH*')
% MinPts - Minimum number of data points per SOM neuron
% mode - string indicating standard kNN ('STD') or modified k-NN ('MOD')
% conn - connectivity type: 4-neighborhood or 8-neighborhood
% Outputs: 
% M - IT-vis matrix
%
% REFERENCES:
% [1] “SOM IT-vis.” [Online]. Available: https://git.mst.edu/acil-group/som-it-vis
% [2] Leonardo Enzo Brito da Silva and Donald C. Wunsch II, “An Information-Theoretic-
% Cluster Visualization for Self-Organizing Maps,” submitted for publication.
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function M = SOM_ITvis(sMap, data, ITvis, mode, MinPts, conn)

    %% Statistics
    [mu, SIGMA_neurons, R] = prototypes_stats(sMap.codebook, data, MinPts, mode);

    switch ITvis
        case 'CIP'
            M = som_cipmat(sMap, R, SIGMA_neurons, conn);
        case 'H*'
            M = som_cipmat(sMap, R, SIGMA_neurons, conn);
            M = log(M+1);
        case 'rCIP'
            M = som_rcipmat(sMap, mu, SIGMA_neurons, conn);
        case 'rH*'
            M = som_rcipmat(sMap, mu, SIGMA_neurons, conn);
            M = log(M+1);
        otherwise
            error('Error. Invalid ITvis type. Input must be one of the following strings: CIP, H*, rCIP or rH*.')
    end
end