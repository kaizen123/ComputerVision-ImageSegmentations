function idx = segmentImg(img, k)
% function idx = segmentImage(img,k)
% Returns the logical image containing the segment ids obtained from 
%   segmenting the input image
%
% INPUTS
% img - The input image containing textured foreground objects to be segmented
%     out.
% k - The number of segments to compute (also the k-means parameter).
%
% OUTPUTS
% idx - The logical image (same dimensions as the input image) contining 
%       the segment ids after segmentation. The maximum value of idx is k.
%          

    % 1. Create your bank of filters using the given alogrithm; 
    % 2. Compute the filter responses by convolving your input image with  
    %     each of the num_filters in the bank of filters F.
    %     responses(:,:,i)=conv2(I,F(:,:,i),'same')
    %     NOTE: we suggest to use 'same' instead of 'full' or 'valid'.
    % 3. Remember to take the absolute value of the filter responses (no
    %     negative values should be used).
    % 4. Construct a matrix X of the points to be clustered, where 
    %     the rows of X = the total number of pixels in I (rows*cols); and
    %     the columns of X = num_filters;
    %     i.e. each pixel is transformed into a num_filters-dimensional
    %     vector.
    % 5. Run kmeans to cluster the pixel features into k clusters,
    %     returning a vector IDX of labels.
    % 6. Reshape IDX into an image with same dimensionality as I and return
    %     the reshaped index image.
    %
     I = double(rgb2gray(img)); 
     Inew = I(:,:,1);  % making img =  3d , hence added 1 in third dim
     F=makeLMfilters;
     [~,~,num_filters] = size(F);
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %                                                                     %
         %                            YOUR CODE HERE                           %
         %                                                                     %
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
      
        % checking variable Image rows and columns as per input image
        % I_rows = number of rows in input/source image
        % I_cols = number of columns in input/source image
        [I_rows, I_cols,~]=size(img); 
        
        % Generating a randomly filled matrix named responses 
        % num_filters = 48
        % taking only absolute values of filter responses.  
        responses = rand(I_rows, I_cols, num_filters);
        for i = 1 : 48
            responses(:,:,i)= abs (conv2(Inew,F(:,:,i),'same'));
                                               
        end
        
        % Reshaping the result into matrix X shaped (rows = I_rows*I_cols, cols = num_filters)
        X = reshape(responses,I_rows * I_cols, num_filters);
        
        % Applying Matlab's K-means for efficiency.
        idx = kmeans(X, k);                    
        
        % Reshaping idx, ie index vector into original image size
        result_img = reshape(idx, I_rows, I_cols);    
        
        % Displaying scaled colors for the result image
        imagesc(result_img)
        title(['Clustered Image with k = ', num2str(k)]);
    
       
        
        %% calling transferImg.m:

        % Defining parameters to be passed: [fgs, idx, sImg, tImg]:
        % fgs = putting foreground indices in vector
        fgs = [2 3];
        % idx = second input is the idx obtained above
        
        % sImg = loaded image / source image

        % tImg = target image / bg image 
        tImg = imread('bg.jpg');
        tImgfinal = double(rgb2gray(tImg)); 
        
        % calling transferImg.m
        newImg = transferImg(fgs, result_img, img, tImg);
        figure;
        imshow (newImg);
        title('Final Image');


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
