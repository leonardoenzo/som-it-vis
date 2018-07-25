% SOM Cross Information Potential (CIP) matrix
%
% PROGRAM DESCRIPTION
% This function generates SOM CIP-vis (heatmap).
%
% DATA & FUNCTION DICTIONARY
% Inputs: 
% sMap - SOM structure
% R - cell containing the data points of each neurons
% SIGMA_neurons - multidimensional array containing the covariance matrices
% for each subset of the data associated with SOM neurons
% conn - connectivity type: 4-neighborhood or 8-neighborhood
% Outputs: 
% M - CIP-vis matrix
%
% REFERENCES:
% [1] “SOM IT-vis.” [Online]. Available: https://git.mst.edu/acil-group/som-it-vis
% [2] Leonardo Enzo Brito da Silva and Donald C. Wunsch II, “An Information-Theoretic-
% Cluster Visualization for Self-Organizing Maps,” submitted for publication.
% [3] A. Ultsch and H. P. Siemon, “Kohonen’s self organizing feature maps
% for exploratory data analysis,” in Proceedings of International Neural
% Networks Conference (INNC). Kluwer Academic Press, 1990, pp.
% 305–308.
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function M = som_cipmat(sMap, R, SIGMA_neurons, conn)

    a = sMap.topol.msize(1);
    b = sMap.topol.msize(2);    
    nrows = 2*a-1;
    ncols = 2*b-1; 
    M = zeros(nrows, ncols);

    % Connections: horizontal, vertical, diagonal
    for i=1:a 
        for j=1:b
            if (j<b) % i=1:a , j=1:b-1 : Scan Columns (horizontal connections)
                ind1 = som_sub2ind([a b],[i j]);
                ind2 = som_sub2ind([a b],[i j+1]);
                M(2*i-1,2*j) = CIP(R{ind1,1}, R{ind2,1}, SIGMA_neurons(:,:,ind1), SIGMA_neurons(:,:,ind2));
            end  
            if (i<a) % j=1:b , i=1:a-1 : Scan Rows (vertical connections)              
                ind1 = som_sub2ind([a b],[i j]);
                ind2 = som_sub2ind([a b],[i+1 j]);
                M(2*i,2*j-1) = CIP(R{ind1,1}, R{ind2,1}, SIGMA_neurons(:,:,ind1), SIGMA_neurons(:,:,ind2));
            end
            if ((i<a)&&(j<b)) % i=1:a-1 , j=1:b-1 : Scan Diagonals (principal / secondary) 	               
                ind1 = som_sub2ind([a b],[i j]);
                ind2 = som_sub2ind([a b],[i+1 j+1]);
                ind3 = som_sub2ind([a b],[i j+1]);
                ind4 = som_sub2ind([a b],[i+1 j]);
                val_prin_diag = CIP(R{ind1,1}, R{ind2,1}, SIGMA_neurons(:,:,ind1), SIGMA_neurons(:,:,ind2));
                val_sec_diag = CIP(R{ind3,1}, R{ind4,1}, SIGMA_neurons(:,:,ind3), SIGMA_neurons(:,:,ind4));
                M(2*i,2*j) = (val_prin_diag + val_sec_diag)/2;
            end
        end
    end    
    %Neurons' Positions
    for i=1:2:nrows 
        for j=1:2:ncols
            ind = NeighborPixels(i, j, nrows, ncols, conn);
            M(i, j) = median(M(ind)); %mean,min,max...  
        end
    end    
end