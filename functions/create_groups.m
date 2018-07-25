% Create Groups 
%
% PROGRAM DESCRIPTION
% This function generates subsets associated with each SOM neuron.
%
% DATA & FUNCTION DICTIONARY
% Inputs: 
% C - SOM neurons matrix 
% data - data matrix
% MinPts - Minimum number of data points per SOM neuron
% mode - string indicating standard kNN ('STD') or modified k-NN ('MOD')
% Outputs: 
% R - cell containing the data points of each neurons
%
% REFERENCES:
% [1] R. O. Duda, P. E. Hart, and D. G. Stork, Pattern Classification, 2nd ed.
% John Wiley & Sons, 2000.
% [2] E. Gokcay and J. C. Principe, “Information theoretic clustering,” IEEE
% Transactions on Pattern Analysis and Machine Intelligence, vol. 24,
% no. 2, pp. 158–171, Feb. 2002.
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function R = create_groups(C, data, MinPts, mode)
    nNeurons = size(C, 1);  % get number of neurons
    nSamples = size(data, 1);  % get number of samples
    R = cell(nNeurons, 1);  % allocate space for subsets associated with each prototype/neuron (H_i)      
    switch mode   
        case 'MOD'  % Modified k-Nearest Neighbors            
            [labels, ~] = som_bmus(data, C);  % get the bmus (labels) for each data sample
            matD = pdist2(data,data,'euclidean');  % generate euclidean distance matrix between neurons
            matD_val = zeros(size(matD));
            matD_ind = zeros(size(matD));
            for i=1:nSamples
                [matD_val(i,:), matD_ind(i,:)] = sort(matD(i,:),'ascend');  % order the distances of all neurons to neuron i
            end
            for i=1:nNeurons
                clc; fprintf('Neuron: %d \n', i); %display neuron number 
                merged = labels(i);    
                nSet = numel(merged);  % number of data points associated with neuron i (cardinality of subset H_i)
                while nSet < MinPts
                    for j=1:length(merged)
                        k = 1;                
                        while true
                            indices(j) = matD_ind(merged(j), k);                 
                            if ismember(indices(j), merged)
                                k = k + 1;
                            else
                                values(j) = matD_val(merged(j), k); 
                                break;
                            end                    
                        end            
                    end                
                    [~, I] = min(values);
                    merged = [merged indices(I)];          
                    indices = [];
                    values = [];       
                    nSet = numel(merged);  % number of data points associated with neuron i (cardinality of subset H_i)
                end    
                R{i,1} = data(merged,:);  % save the MinPts data points closest to neuron i         
            end              
        case 'STD'  % Standard k-Nearest Neighbors  
            [labels, ~] = som_bmus(C, data);  % get the bmus (labels) for each data sample   
            mat = pdist2(C, data);  % generate distance/dissimilarity matrix between neurons and data points
            for i=1:nNeurons  % for each prototype/neuron    
                clc; fprintf('Neuron: %d \n', i); % display neuron number
                ind = labels==i;  % get the indices of data points for which neuron i is the BMU 
                nSet = sum(ind);  % number of data points associated with neuron i (cardinality of subset H_i)
                if nSet >= MinPts  % if the number of data points of subset of neuron i exceeds the minimum/threshold 
                    R{i, 1} = data(ind, :);  % save data points associated with neuron i (subset H_i)    
                else  % if the number of data points of subset of neuron i is less than the minimum/threshold 
                    [~, index] = sort(mat(i,:),'ascend');  % order the distances of points to neuron i
                    R{i, 1} = data(index(1:MinPts), :);  % save the MinPts data points closest to neuron i   
                end
            end        
    end    
end