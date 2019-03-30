% CSCI 631 Programming Assignment 2, run_me.m
% Trisha P. Malhotra

    %%---------------------------------------------%%
    %       Reading the image
    %%---------------------------------------------%%

    % srcFiles = dir('Users/tpm/Desktop/Computer Vision/homework2/images/*.jpg');
    img = imread('gecko.jpg');

    %%---------------------------------------------%%
    %       Calling segmentImg.m 
    %%---------------------------------------------%%

    % Defining number of clusters : k , for kmeans    
    k = 3;                                 
    % Passing input image, and k as parameters
    result_img = segmentImg(img, k);
    
    % Calling transferImg.m from segmentImg.m

 
       