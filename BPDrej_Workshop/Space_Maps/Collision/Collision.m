%Collision Land Generation
%TechChariot
%7.27.22

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])
filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = path(1:102); addpath(path) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

%A = 1; B = 2; C = 3;

%[D,E,F,G] = LandScribeV6(B,A,C)



%off =  [45];           %Player Starting Offset Angle
%SA  =  [0];           %Player Starting Seed Angle
%b   =  [0.0];          %Player Starting team bias factor
%r   =  [10];           %Player Starting Group radius
%e   = 0.5; e = 2*e;    %Player Starting Eccentricity
%
%[create_player_lands] = RMS_CPL_V2({1},{'GRASS'},{0},off,SA,b,r,e);



%MLA                  = [{'create_land'}; ...
%                        {'{'}; ...
%                        {'terrain_type GRASS'}; ...
%                        {'land_percent 100'}; ...
%                        {'land_position 1 99'}; ...
%                        {'base_elevation 0'}; ...
%                        {'}'}; ...
%                        ('create_land'); ...
%                        {'{'}; ...
%                        {'terrain_type DIRT'}; ...
%                        {'land_percent 100'}; ...
%                        {'land_position 99 1'}; ...
%                        {'base_elevation 0'}; ...
%                        {'}'}];

MLA = [];


%NL = 1;
%for i = 1:NL
%MLA =   [MLA; ...
%        ('create_land'); ...
%        {'{'}; ...
%        {'terrain_type DLC_WETROCKBEACH'}; ...
%        {'base_size 1'}; ...
%%        {'number_of_tiles rnd(40,50)'}; ...
%        {'land_percent 100'}; ...
%%        {'border_fuziness 100'}; ...
%%        {'min_placement_distance 9'}; ...
%%        {'top_border 66 right_border 66'}; ...
%%        {'start_random'}; ...
%%Corner Squares
%%        {'percent_chance 11 top_border 67 bottom_border 0  left_border 67 right_border 0'}; ...
%%        {'percent_chance 11 top_border 0  bottom_border 67 left_border 67 right_border 0'}; ...
%%        {'percent_chance 11 top_border 0  bottom_border 67 left_border 0  right_border 66'}; ...
%%        {'percent_chance 11 top_border 67 bottom_border 0  left_border 0  right_border 66'}; ...
%%Side Squares
%%        {'percent_chance 11 top_border 67 bottom_border 33 left_border 67 right_border 33'}; ...
%%        {'percent_chance 11 top_border 33 bottom_border 67 left_border 67 right_border 33'}; ...
%%        {'percent_chance 11 top_border 33 bottom_border 67 left_border 33 right_border 66'}; ...
%%        {'percent_chance 11 top_border 67 bottom_border 33 left_border 33 right_border 66'}; ...
%%Testbed
%        {['top_border ' num2str(bx(2,:)) ' bottom_border ' num2str(bx(1,:)) ' left_border ' num2str(by(2,:)) ' right_border ' num2str(by(1,:))]}; ...
%%        {'end_random'}; ...
%        {'}'}];
%end
%%
%

%config = {1}; k = 1;
%
Barrier = [LandScribeV5({'GRASS'},[{0}],{00 35},{45},{'0.015*x.^2'},{1},{40},sqrt(2)*[-50 50]); ...
           LandScribeV5({'DIRT'},[{0}],{00 -35},{45},{'-0.015*x.^2'},{1},{40},sqrt(2)*[-50 50])];
%
%
%COMMAND(k).XY = [RMS_Processor_V4(Barrier,LPM_exp)];
%[CODE] = RMS_RS_V3(config,{'C'},COMMAND);

%O = 45;
O = 45; k = 0;
Land_Bordered = [];
for i = 01:10:101

x(i,1) = i;
%y1(i,1) = 0.01*x(i,1).^2;
y2(i,1) =  0.01*x(i,1).^2;
%y2(i,1) = -0.01*(x(i,1)-50).^2+40;

k = k + 1;
P(k,:) = [x(i,1) y2(i,1)];


Land_Bordered = [Land_Bordered; LSB({'ICE'},{2},{0},{400},{9},{[P(k,1) P(k,2)]},{[1 1]},{'None'})];
end
%

CODE = [Land_Bordered];


%
%ObjectAutoscribeV8('ObjectDatabase.ods')
CODE = [Preface; CODE; MLA]; %Adding Preface, Definitions, Random Statement to beginning of CODE
RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc
