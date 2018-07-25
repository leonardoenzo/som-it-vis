% Neighbor Pixels  
%
% PROGRAM DESCRIPTION
% This function obtains the neighbors of a pixel considering a
% 4-neighborhood or 8-neighborhood.
%
% DATA & FUNCTION DICTIONARY
% Inputs: 
% I - input pixel row
% J - input pixel column
% M - total number of rows of the image
% N - total number of columns of the image
% conn - connectivity type: 4-neighborhood or 8-neighborhood
% Outputs: 
% ind - linear indices of neigboring pixels
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ind = NeighborPixels(I, J, M, N, conn) 
    pixel = [I, J];
    if pixel(1)>1 && pixel(2)>1 && pixel(1)<M && pixel(2)<N  % MIDDLE
        neigh(1, 1:2) = [pixel(1)-1   pixel(2)];   % UP
        neigh(2, 1:2) = [pixel(1)+1   pixel(2)];   % DOWN
        neigh(3, 1:2) = [pixel(1)     pixel(2)-1]; % LEFT
        neigh(4, 1:2) = [pixel(1)     pixel(2)+1]; % RIGHT
        if conn==8
            neigh(5, 1:2) = [pixel(1)-1   pixel(2)-1]; % UP-LEFT MAIN DIAGONAL 1
            neigh(6, 1:2) = [pixel(1)+1   pixel(2)+1]; % DOWN-RIGHT MAIN DIAGONAL 2
            neigh(7, 1:2) = [pixel(1)-1   pixel(2)+1]; % UP-RIGHT SECONDARY DIAGONAL 1
            neigh(8, 1:2) = [pixel(1)+1   pixel(2)-1]; % DOWN-LEFT SECONDARY DIAGONAL 2 
        end
    elseif pixel(1)==1 && pixel(2)>1 && pixel(2)<N % ROW 1 
        neigh(1, 1:2) = [pixel(1)+1   pixel(2)];   % DOWN
        neigh(2, 1:2) = [pixel(1)     pixel(2)-1]; % LEFT
        neigh(3, 1:2) = [pixel(1)     pixel(2)+1]; % RIGHT
        if conn==8
            neigh(4, 1:2) = [pixel(1)+1   pixel(2)+1]; % DOWN-RIGHT MAIN DIAGONAL 2
            neigh(5, 1:2) = [pixel(1)+1   pixel(2)-1]; % DOWN-LEFT SECONDARY DIAGONAL 2 
        end
    elseif pixel(1)==M && pixel(2)>1 && pixel(2)<N % ROW M         
        neigh(1, 1:2) = [pixel(1)-1   pixel(2)];   % UP        
        neigh(2, 1:2) = [pixel(1)     pixel(2)-1]; % LEFT
        neigh(3, 1:2) = [pixel(1)     pixel(2)+1]; % RIGHT
        if conn==8
            neigh(4, 1:2) = [pixel(1)-1   pixel(2)-1]; % UP-LEFT MAIN DIAGONAL 1        
            neigh(5, 1:2) = [pixel(1)-1   pixel(2)+1]; % UP-RIGHT SECONDARY DIAGONAL 1   
        end
    elseif pixel(2)==1 && pixel(1)>1 && pixel(1)<M % COL 1 
        neigh(1, 1:2) = [pixel(1)-1   pixel(2)];   % UP
        neigh(2, 1:2) = [pixel(1)+1   pixel(2)];   % DOWN
        neigh(3, 1:2) = [pixel(1)     pixel(2)+1]; % RIGHT
        if conn==8
            neigh(4, 1:2) = [pixel(1)+1   pixel(2)+1]; % DOWN-RIGHT MAIN DIAGONAL 2
            neigh(5, 1:2) = [pixel(1)-1   pixel(2)+1]; % UP-RIGHT SECONDARY DIAGONAL 1   
        end
    elseif pixel(2)==N && pixel(1)>1 && pixel(1)<M % COL N
        neigh(1, 1:2) = [pixel(1)-1   pixel(2)];   % UP
        neigh(2, 1:2) = [pixel(1)+1   pixel(2)];   % DOWN
        neigh(3, 1:2) = [pixel(1)     pixel(2)-1]; % LEFT 
        if conn==8
            neigh(4, 1:2) = [pixel(1)-1   pixel(2)-1]; % UP-LEFT MAIN DIAGONAL 1
            neigh(5, 1:2) = [pixel(1)+1   pixel(2)-1]; % DOWN-LEFT SECONDARY DIAGONAL 2  
        end
    elseif pixel(1)==1 && pixel(2)==1 % CORNER UP-LEFT      
        neigh(1, 1:2) = [pixel(1)+1   pixel(2)];   % DOWN        
        neigh(2, 1:2) = [pixel(1)     pixel(2)+1]; % RIGHT   
        if conn==8
            neigh(3, 1:2) = [pixel(1)+1   pixel(2)+1]; % DOWN-RIGHT MAIN DIAGONAL 2     
        end
    elseif pixel(1)==1 && pixel(2)==N % CORNER UP-RIGHT      
        neigh(1, 1:2) = [pixel(1)+1   pixel(2)];   % DOWN
        neigh(2, 1:2) = [pixel(1)     pixel(2)-1]; % LEFT
        if conn==8
            neigh(3, 1:2) = [pixel(1)+1   pixel(2)-1]; % DOWN-LEFT SECONDARY DIAGONAL 2      
        end
   elseif pixel(1)==M && pixel(2)==1 % CORNER DOWN-LEFT    
        neigh(1, 1:2) = [pixel(1)-1   pixel(2)];   % UP
        neigh(2, 1:2) = [pixel(1)     pixel(2)+1]; % RIGHT
        if conn==8
            neigh(3, 1:2) = [pixel(1)-1   pixel(2)+1]; % UP-RIGHT SECONDARY DIAGONAL 1
        end
    elseif pixel(1)==M && pixel(2)==N % CORNER DOWN-RIGHT  
        neigh(1, 1:2) = [pixel(1)-1   pixel(2)];   % UP
        neigh(2, 1:2) = [pixel(1)     pixel(2)-1]; % LEFT
        if conn==8
            neigh(3, 1:2) = [pixel(1)-1   pixel(2)-1]; % UP-LEFT MAIN DIAGONAL 1
        end
    end
    SIZ = [M N];
    len = size(neigh, 1);
    ind = zeros(1, len); 
    for i=1:len
        ind(i) = sub2ind(SIZ, neigh(i,1), neigh(i,2));
    end    
end
