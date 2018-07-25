% Plot SOM IT-vis
%
% PROGRAM DESCRIPTION
% This function plots the IT-vis.
%
% DATA & FUNCTION DICTIONARY
% Inputs: 
% IT-vis - string indicating the type of IT-vis ('CIP', 'H*', 'rCIP', 'rH*')
% view_type - string indicating the type of plot ('top_surface', 'heatmap', '3d_surface', 'contour_lines')
% Mat - IT-vis matrix
%
% Code written by Leonardo Enzo Brito da Silva
% Under the supervision of Dr. Donald C. Wunsch II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = visualize(ITvis, view_type, Mat) 

    figure('NumberTitle', 'off', 'Name', ITvis);
    switch view_type
        case 'top_surface'        
            pcolor(Mat)
            set(gca,'FontSize', 20)
            set(gca,'Ydir', 'reverse')
            set(gcf, 'Color', 'w')
            title(ITvis)
            axis square
            colormap('gray')
            colorbar; 
        case 'heatmap'
            imshow(Mat,[],'InitialMagnification','fit'); 
            set(gca,'FontSize', 20)
            set(gcf, 'Color', 'w')
            title(ITvis)
            colorbar;         
        case '3d_surface'
            surface(Mat)
            shading interp
            set(gca,'FontSize', 20)
            set(gcf, 'Color', 'w')
            title(ITvis)
            axis square
            colormap('gray')
            colorbar;   
            view([-60 60]);
        case 'contour_lines'
            N = input('How many contour levels?'); 
            contour(Mat, N)
            axis square
            colormap('gray')
            colorbar;  
    end

end
