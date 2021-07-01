% This is a demo script demonstrating Region based Adaptive dehazing 
% Details enhancement and pre-processing using auto-color transfer method
% Balla Pavan Kumar, Arvind Kumar and Rajoo Pandey
% 
% Paper is not published yet, details will be updated once the paper is
% published. If you use this code, please cite our paper.
% 
% 
% Please read the instructions on README.md in order to use this code.
%
% Author: Balla Pavan Kumar (kumarballapavan@gmail.com)
%
% The software code is provided under the attached LICENSE.md


clc;
clear all;
close all;

DB = 'Hazy Images';
GT = 'Ground Truth images';
output_folder = 'Dehazing_Results';
if ~isdir(DB)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', DB);
  uiwait(warndlg(errorMessage));
  return;
end

if ~isdir(GT)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', GT);
  uiwait(warndlg(errorMessage));
  return;
end

filePattern1 = fullfile(DB, '*.png');
filePattern2 = fullfile(GT, '*.png');

pngFiles1 = dir(filePattern1);
pngFiles2 = dir(filePattern2);count=0;
global_count=0;

for k = 1:length(pngFiles1)
  baseFileName1 = pngFiles1(k).name;
  fullFileName1 = fullfile(DB, baseFileName1);j=0;
  global_count=global_count+1;
  
  for i = 1:length(pngFiles2)
    baseFileName2 = pngFiles2(i).name;
    fullFileName2 = fullfile(GT, baseFileName2);
    if strcmp(baseFileName1,baseFileName2) && j==0
    j=1;
%     disp('Both Hazy and GT images are available');
    imageArray1 = imread(fullFileName1);
    imageArray2 = imread(fullFileName2);
    [filepath,name,ext] = fileparts(baseFileName1);
    dehazed=main(imageArray1, imageArray2, global_count, j, name, output_folder);
    %imshow([imageArray1 dehazed]);title('Hazy vs Dehazed image');
%     imshow([imageArray1 imageArray2]);  % Display image.
%     drawnow; % Force display to update immediately.
    %pause(2);
    %count=count+1;
    end        
  end
  
  if j==0
      imageArray2=imread(fullFileName1);
      imageArray1= imageArray2;
      [filepath,name,ext] = fileparts(baseFileName1);
      dehazed=main(imageArray1, imageArray2, global_count, j, name,output_folder);
       %imshow([imageArray1 dehazed]);title('Hazy vs Dehazed image');
      count=count+1;
      %disp('Only Hazy image is available');
      %fprintf(1, 'Only Hazy image is %s \n', baseFileName1);
      
  end
%   if k==2
%   break;
%   end
end

