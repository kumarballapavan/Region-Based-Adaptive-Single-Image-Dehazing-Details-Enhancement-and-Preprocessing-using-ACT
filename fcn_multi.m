function [out_img, time, trans_map, A] = fcn_multi(img,temp)

%The main function of multi-band enhancement.
% 
% The details of the algorithm are described in this paper: 
% Model Assisted Multi-band Fusion for Single Image Enhancement and Applications to Robot Vision
% Y. Cho, J. Jeong, A. Kim, IEEE RA-L, 2018
% which can be found at:
% http://irap.kaist.ac.kr/publications/ycho-2018-ral.pdf
% This code is inspired from the above paper, if you use this code, please
% cite the above paper.
%
%   Input arguments:
%   ----------------
%	- img : input haze image, type "double"
%	- scale_smooth : predifined smoothing factors (epsilon)
%	- scale_mapping : parameters for mapping function (optional)
%   - box_size: size of default box for filtering
%
%   Output arguments:
%   ----------------
%   - out_img: output dehazed image
%   - trans_map: transmission map
%   - A: ampbient light
%
% Author: Younggun Cho (yg.cho@kaist.ac.kr)
%
% The software code is provided under the attached LICENSE.md

if temp==3
scale_smooth = [1e-6,1e-5,1e-4,1e-3,1e-2];
% scale_smooth = [1e-5,1e-4,1e-3,1e-2,1e-1];
scale_mapping = {[0.5,40], [0.8, 30], [0.8, 30],[0.8, 20],[0.8, 10]};
%scale_smooth = [1e-6];
%scale_mapping = {[0.5,40]};
% disp('In temp=3');
end

if temp==2
scale_smooth = [1e-6,1e-5,1e-4,1e-3,1e-2];
% scale_smooth = [1e-5,1e-4,1e-3,1e-2,1e-1];
scale_mapping = {[0.5,30], [0.8, 20], [0.8, 30],[0.8, 10],[0.8, 10]};
%scale_smooth = [1e-6];
%scale_mapping = {[0.5,30]};
% disp('In temp=2');
end

if temp==1
scale_smooth = [1e-6,1e-5,1e-4,1e-3,1e-2];
% scale_smooth = [1e-5,1e-4,1e-3,1e-2,1e-1];
scale_mapping = {[0.5,20], [0.8, 20], [0.8, 10],[0.8, 10],[0.8, 10]};
%scale_smooth = [1e-6];
%scale_mapping = {[0.5,20]};
% disp('In temp=1');
end

%if temp==4
%scale_smooth = [1e-6,1e-5,1e-4,1e-3,1e-2];
%scale_mapping = {[0.5,20], [0.8, 20], [0.8, 10],[0.8, 10],[0.8, 10]};
%disp('In temp=4');
%end


%disp(scale_smooth)
%scale_mapping = {[0.5, 40], [0.8, 40], [0.8, 10]};
box_size = 20;

tic;

[out_img, amb_map, trans_map, A] = fcn_multiscale_enhancement(img, img, box_size, scale_smooth, scale_mapping);
amb_map=rgb2gray(amb_map);
%figure; imshow(amb_map); title('amb_map');
%trans_map=trans_map
%imwrite(trans_map,'trans_map.jpg');
%colormap jet
%figure; imshow(trans_map); title('trans map');
%colormap jet
adj_percent = [0.005, 0.995];
out_img = imadjust(out_img, adj_percent);

time = toc;

