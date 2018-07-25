% Prototypes' Statistics 
%
% PROGRAM DESCRIPTION
% This function computes the means and covariance matrices associated with
% each SOM neuron.
%
% DATA & FUNCTION DICTIONARY
% Inputs: 
% C - SOM neurons matrix 
% data - data matrix
% MinPts - Minimum number of data points per SOM neuron
% mode - string indicating standard kNN ('STD') or modified k-NN ('MOD')
% Outputs: 
% mu - matrix of means
% SIGMA_neurons - multidimensional matrix of covariances
% R - cell containing the data points of each neurons
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mu, SIGMA_neurons, R] = prototypes_stats(C, data, MinPts, mode)
    [nNeurons, dim] = size(C);  % get number of neurons & data dimensionality 
    R = create_groups(C, data, MinPts, mode);  % get subsets of data associated with each prototype/neuron (H_i)    
    SIGMA_neurons = zeros(dim, dim, nNeurons);  % allocate space for covariance matrix associated with each prototype/neuron
    mu = zeros(nNeurons, dim);  % allocate space for mean associated with each prototype/neuron 
    for i=1:nNeurons  % for each prototype/neuron    
        SIGMA_neurons(:, :, i) = cov([R{i, 1} ; C(i, :)]);  % compute the covariance matrix of data points associated with neuron i (subset H_i) - including neuron
        mu(i, :) = mean(R{i, 1}, 1); % compute the mean of data points associated with neuron i (subset H_i) - including it
    end
end