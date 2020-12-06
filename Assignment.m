function gaussianFilter()
    S = im2double(rgb2gray(imread('D:\AUST\4.2\DIP Lab\Lab 4\Lab-04\Noise Filtering-Images\coloredChips.png')));
    R = S;
    [row, col] = size(S);
    prompt = 'Enter the sigma value: ';
    sigma = input( prompt );
    
    %design 3x3 kernel with sigma value
    C = 1/ (2*pi*sigma*sigma);
    X = [-1 0 1; -1 0 1; -1 0 1];
    Y = [-1 -1 -1; 0 0 0; 1 1 1];
    K = C * exp(-1 *((X.^2) + (Y.^2))/ (2*sigma*sigma));
    % normalize kernel - otherwise brightness issue arises as sum of kernel
    % is no longer 1 after our operations
    K = K / sum(K(:));
    
    %zero padding
    S = padarray(S,[1 1]);
    
    %apply filter
    for i = 1:row-2
       for j = 1:col-2
           N = S(i:i+2, j:j+2);
           t = N .* K;
           t = sum(t(:));
           R(i,j) = t;
       end
    end
    
    figure; imshow(S);
    figure; imshow(R);
    
end