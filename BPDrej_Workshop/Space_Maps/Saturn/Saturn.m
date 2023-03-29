%Saturn Land Generation
%BPDrej
%3.28.23

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])
filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = path(1:90); addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

b = 25;
b2 = 34;
for i=1:360
x(i,1) = b*cosd(i);
y(i,1) = b*sind(i);
x1(i,1) = b2*cosd(i);
y1(i,1) = b2*sind(i);
end
%
M = [x y]; CC = [50 50];
M1 = [x1 y1]; CC = [50 50];

R = LandScribeV5([{'GRASS'}],[{0}],{CC},{45},{M},{1});
R1 = LandScribeV5([{'GRASS'}],[{0}],{CC},{45},{M1},{1});

COMMAND = [RMS_Processor_V4([R; R1],LPM_exp); ];

MLA = [{'create_player_lands { terrain_type DIRT circle_radius 13 0 base_size 5 base_elevation 1 land_percent 100 zone 1 other_zone_avoidance_distance 0 }'}];


%ObjectAutoscribeV8('ObjectDatabase.ods')
CODE = [Preface; MLA; COMMAND]; %Adding Preface, Definitions, Random Statement to beginning of CODE
RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc

