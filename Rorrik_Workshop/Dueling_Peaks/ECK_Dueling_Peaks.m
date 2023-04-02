%ECK_Dueling_Peaks Player Land Generation
%TechChariot
%4.01.23

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])

filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = path(1:90); addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

CODE = Preface;

%% -- INPUT FORMAT -- %%
% G = [{Vector of Radii}; ...
%      {Vector of Angular Offsets Between Flank and Pocket}; ...
%      {Vector of Angular Distance to Centroid of Teams}; ...
%      {Vector of Clocking "Seed Angles"}; ...
%      {Vector of Team Biases}; ...
%      {Vector of Eccentricities}; ...
%      {Matrix of Team Centers}] (geometric inputs)

% C = [{Base Elevation}; ...
%      {Base Size}; ...
%      {Number of Tiles}; ...
%      {Zone Avoidance}; ...
%      {Linear Slop};
%      {[left right top bottom] border avoidances}]  (characteristic inputs)

size_prefix = [{'if TINY_MAP'} {'elseif SMALL_MAP'} {'elseif MEDIUM_MAP'} {'elseif LARGE_MAP'} {'elseif HUGE_MAP'} {'elseif GIGANTIC_MAP'} {'endif'}];


for i = 1:7
if i == 7
CODE = [CODE; size_prefix(i)];
else
end
%
[PLB] = RMS_CPL_V9([{[21]}; {[45]}; {[180]}; {[0]}],[{0}; {0}; {0}; {8}; {0}]); %Player-Land-Base
[PLP] = Circular_Variable_Lands_V2([{[11]}; {[45]}; {[180]}; {[0]}],[{7}; {0}; {0}; {0}; {0}]); %Circular Variable Land, Following Player Lands
CODE = [CODE; size_prefix(i); PLB; PLP];
end
%

RMS_ForgeV4(filename,CODE);
%ObjectAutoscribeV8('RREC_Arabia.ods')
disp(["Run Completed " datestr(clock) "..."])
toc
