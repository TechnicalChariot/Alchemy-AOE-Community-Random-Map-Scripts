%Tidal_Locked_V2 Land Generation
%BPDrej
%2.11.23

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])
filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = path(1:90); addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

b = 22;
ecc = 0.91;
for ri=1:180
rr(ri,1) = b/sqrt(1-(ecc*cosd(ri))^2);
rx(ri,1) = rr(ri,1)*cosd(ri);
ry(ri,1) = rr(ri,1)*sind(ri);
end
%
RM = [rx ry]; RC = [86 50]; LC = [13 50];
RP = LandScribeV5([{'GRASS'}],[{1}],{RC},{90},{RM},{1});
LP = LandScribeV5([{'GRASS'}],[{1}],{LC},{270},{RM},{1});

b = 13;
ecc = 0;
for i=1:360
r(i,1) = b/sqrt(1-(ecc*cosd(i))^2);
x(i,1) = r(i,1)*cosd(i);
y(i,1) = r(i,1)*sind(i);
end
%
M = [x y]; CC = [50 50];
%tail = LandScribeV5([{'GRASS'}],[{0}],{[0 -30]},{-45},{'0*x'},{1},{60},[-20 20;-50 50]);
TL = LandScribeV5([{'GRV'}],[{1}],{CC},{45},{M},{1});

tag = [{'if P2'};{'elseif P4'};{'elseif P6'};{'elseif P8'};{'endif'}];

%% -- CPL_V9 INPUT FORMAT -- %%
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

%G = [{52}; {45}; {180}; {90}; {[0.05]}; {0.6}; {[-12 50; 112 50]}];
%G = [{52}; {45}; {180}; {90}; {[0.3]}; {0.6}; {[-28 50; 128 50]}];

%C = [{1}; {0}; {14400}; {0}; {0}; {[0 0 0 0]}];

%[create_player_lands] = RMS_CPL_V9(G,C);


COMMAND = [RMS_Processor_V4([TL; RP; LP],LPM_exp); create_player_lands];

MLA = [];


%ObjectAutoscribeV8('ObjectDatabase.ods')
CODE = [Preface; COMMAND; MLA]; %Adding Preface, Definitions, Random Statement to beginning of CODE
RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc
