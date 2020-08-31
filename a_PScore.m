%% These codes were selected according to the P-Score.
%% Sample code
close all; clear; clc;
%% Verilerin yüklenmesi
load Sample_Data

%% Performance Based Feature Selection
% Here the properties will be classified sequentially. Performance values
% will be calculated for each feature.
A=[X Y]; % Matrix for Feature Selection

%% Feature Selection
tic
[N_P_A,N_P_A_20,P_A,P_A_20]=P_Score_H(A);
T_A=toc;

% Information
% N_P_A - Number of features exceeding threshold value
% N_P_A_20 - Best 20% number of features (Matrix that can be used in future studies.)
% P_A - Matrix built with properties that exceed the threshold value
% P_A_20 -  Matrix created with the best 20% features Matrix that can be used in future studies.)



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saving files
save P_Score