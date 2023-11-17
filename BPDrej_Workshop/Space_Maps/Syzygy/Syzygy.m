%Syzygy Land Generation
%BPDrej
%11.16.23

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])
filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = path(1:90); addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

b = 23
b1 = 23
##b2 = 23
##b3 = 23
nr = 16;
r = linspace(0,15,nr);
for i=1:360
for j=1:nr
x(i,j) = r(j)*cosd(i);
y(i,j) = r(j)*sind(i);
x1(i,j) = r(j)*cosd(i);
y1(i,j) = r(j)*sind(i);
x2(i,j) = r(j)*cosd(i);
y2(i,j) = r(j)*sind(i);
x3(i,j) = r(j)*cosd(i);
y3(i,j) = r(j)*sind(i);
end
##r2(i,1) = b2/sqrt(1-(ecc*cosd(i))^2);
##x2(i,1) = r2(i,1)*cosd(i);
##y2(i,1) = r2(i,1)*sind(i);
##r3(i,1) = b3/sqrt(1-(ecc*cosd(i))^2);
##x3(i,1) = r3(i,1)*cosd(i);
##y3(i,1) = r3(i,1)*sind(i);
end
%
x = reshape(x,360*nr,1);
y = reshape(y,360*nr,1);
x1 = reshape(x1,360*nr,1);
y1 = reshape(y1,360*nr,1);
x2 = reshape(x2,360*nr,1);
y2 = reshape(y2,360*nr,1);
x3 = reshape(x3,360*nr,1);
y3 = reshape(y3,360*nr,1);
M = [x y]; CC = [70 30];
M1 = [x1 y1]; CC1 = [55 45];
M2 = [x2 y2]; CC2 = [45 55];
M3 = [x3 y3]; CC3 = [30 70];

R = LandScribeV5([{'DLC_GRAVELBEACH'}],[{1}],{CC},{45},{M},{1});
R1 = LandScribeV5([{'B3'}],[{1}],{CC1},{45},{M1},{1});
R2 = LandScribeV5([{'BEACH'}],[{1}],{CC2},{45},{M2},{1});
R3 = LandScribeV5([{'WRB'}],[{1}],{CC3},{45},{M3},{1});
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

G = [{[20 24]}; {45}; {180}; {45}; {[0.15]}; {0.6}; {[CC; CC]}];
C = [{1}; {0}; {14400}; {0}; {0}; {[0 0 0 0]}];


[create_player_lands] = RMS_CPL_V9(G,C);


COMMAND = [RMS_Processor_V4([R3; R2; R1; R],LPM_exp);];

##MLA = [{'L { terrain_type GRASS land_position 1 1 base_size 0 number_of_tiles 12000 }'}];


##%ObjectAutoscribeV8('Comet_V2.ods')
CODE = [Preface; COMMAND]; %Adding Preface, Definitions, Random Statement to beginning of CODE
RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc

