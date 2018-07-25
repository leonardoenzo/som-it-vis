% Cross Information Potential 
%
% PROGRAM DESCRIPTION
% This function computes the (representative) cross information potential 
% (rCIP/CIP) between two distributions.
%
% DATA & FUNCTION DICTIONARY
% Inputs: 
% f - points of distribution 1
% g - points of distribution 2
% SIGMA_f - covariance matrix of distribution 1
% SIGMA_g - covariance matrix of distribution 2
% Outputs: 
% V - cross information potential value
%
% REFERENCES:
% [1] E. Gokcay and J. C. Principe, “Information theoretic clustering,” IEEE
% Transactions on Pattern Analysis and Machine Intelligence, vol. 24,
% no. 2, pp. 158–171, Feb. 2002. 
% [2] S. Rao, A. Martins, and J. C. Principe, “Mean shift: An information
% theoretic perspective,” Pattern Recognition Letters, vol. 30, no. 3, pp.
% 222 – 230, 2009.
% [3] D. Araújo, A. D. Neto, and A. Martins, “Representative cross information
% potential clustering,” Pattern Recognition Letters, vol. 34, no. 16,
% pp. 2181 – 2191, 2013.
% [4] D. Araújo, A. D. Neto, and A. Martins, “Information-theoretic clustering:
% A representative and evolutionary approach,” Expert Systems with
% Applications, vol. 40, no. 10, pp. 4190 – 4205, 2013.
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function V = CIP(f, g, SIGMA_f, SIGMA_g)
    N1 = size(f, 1);
    N2 = size(g, 1);
    sum1 = 0;
    for i=1:N1
        for j=1:N2
            X = f(i,:);
            mu = g(j,:);
            SIGMA = SIGMA_f + SIGMA_g;
            sum1 = sum1 + mvnpdf(X, mu, SIGMA);           
        end
    end    
    V = (1/(N1*N2))*sum1;      
end