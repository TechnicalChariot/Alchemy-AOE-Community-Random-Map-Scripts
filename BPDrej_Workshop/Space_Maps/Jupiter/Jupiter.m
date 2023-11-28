%Collision Land Generation
%TechChariot
%7.27.22

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])
filestruc = dir; %Extract a1 structure of the files in this directory
path = filestruc.folder; path = path(1:102); addpath(path) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

% G = [{Vector of Radii}; ...
%      {Vector of Angular Offsets Between Flank and Pocket}; ...
%      {Vector of Angular Distance to Centroid of Teams}; ...
%      {Vector of Clocking "Seed Angles"}; ...
%      {Vector of Team Biases}; ...
%      {Vector of Eccentricities}] (geometric inputs)

% C = [{Base Elevation}; ...
%      {Base Size}; ...
%      {Land Percent}; ...
%      {Zone Avoidance}; ...
%      {Linear Slop}]  (characteristic inputs)

[PL] = RMS_CPL_V7([{[28 30 32]}; {[43 45 47]}; {[170 180 190]}; {[-45]}; {[0 0.05]}; {[1]}],[{0}; {0}; {0}; {0}]);


NL = round(8*[1.4 2.1 2.8 4.0 4.8 5.8]);
for j = 1:length(NL)
if j == 1
MLA = ['if TINY_MAP']; %Initializing Manual Land Appendix  
elseif j == 2
MLA = [MLA; 'elseif SMALL_MAP'];
elseif j == 3
MLA = [MLA; 'elseif MEDIUM_MAP'];
elseif j == 4
MLA = [MLA; 'elseif LARGE_MAP'];
elseif j == 5
MLA = [MLA; 'elseif HUGE_MAP'];
else
MLA = [MLA; 'elseif GIGANTIC_MAP'];
endif
%
for i = 1:NL(j)
MLA =   [MLA; ...
        ('create_land'); ...
        {'{'}; ...
        {'terrain_type DLC_WETROCKBEACH'}; ...
        {'base_size rnd(1,2)'}; ...
        {'number_of_tiles rnd(40,50)'}; ...
        {'min_placement_distance 9'}; ...
        {'start_random'}; ...
        {'percent_chance 11 top_border 66 left_border 66'}; ...
        {'percent_chance 11 bottom_border 66 left_border 66'}; ...
        {'percent_chance 11 bottom_border 66 right_border 66'}; ...
        {'percent_chance 11 top_border 66 right_border 66'}; ...
        {'end_random'}; ...
        {'}'}];
end        
end
%
MLA = [MLA; 'endif'];




%Angular Orientation of Various Shapes
Angle = [{0}];

%Basic Parameters
r  = [{1};];     %Aspect Ratio of the Oasis

JET = [{'R2'}];

na1 = length(JET); %Jupiter Edge Terrain


a1max = 40; s = 2; 
a1 = [a1max:-s:(a1max-s*(length(JET)-1))];

R = [{}]; 
OL = 0.75; %Overlap parameter
for i = 1:na1
f1 = [{['-' mat2str(r{1}) '*sqrt(' mat2str(a1(i)) '^2 - x.^2)']}]; %Function 1 
f2 = [{[    mat2str(r{1}) '*sqrt(' mat2str(a1(i)) '^2 - x.^2)']}]; %Function 2 
[R1] = LandScribeV5(JET(i),{0},{0 0},Angle(1),f1,{2},{1},OL*[-a1(i) a1(i)]); %Ring 1
[R2] = LandScribeV5(JET(i),{0},{0 0},Angle(1),f2,{2},{1},OL*[-a1(i) a1(i)]); %Ring 2
[R3] = LandScribeV5(JET(i),{0},{0 0},{Angle{1}+90},f1,{2},{1},OL*[-a1(i) a1(i)]); %Ring 1
[R4] = LandScribeV5(JET(i),{0},{0 0},{Angle{1}+90},f2,{2},{1},OL*[-a1(i) a1(i)]); %Ring 2
R = [R; R1; R2; R3; R4] ;
end
 
JE = R; %Jupiter Edge
clear R





ET = [{'R'}; {'R'}; {'R'}; {'R'}]; %Eye Terrain

a2min = 0;
a2 = [a2min:s:(a2min+s*(length(ET)-1))];
na2 = length(ET); %Eye Terrain
r = {0.75}; Angle = {45};

for j = 1:2
R = [{}]; 
for i = 1:na2
f1 = [{['-' mat2str(r{1}) '*sqrt(' mat2str(a2(i)) '^2 - x.^2)']}]; %Function 1 
f2 = [{[    mat2str(r{1}) '*sqrt(' mat2str(a2(i)) '^2 - x.^2)']}]; %Function 2 
[R1] = LandScribeV5(ET(i),{0},{0 (-1)^j*25},{Angle{1}},f1,{2},{1},[-a2(i) a2(i)]); %Ring 1
[R2] = LandScribeV5(ET(i),{0},{0 (-1)^j*25},{Angle{1}},f2,{2},{1},[-a2(i) a2(i)]); %Ring 2
R = [R; R1; R2;] ;
end
% 
EE(j).XY = R; %Eye Edge Structure
clear R
end
%

 SL = 38; offy = 2;
Y = linspace(-SL+offy,SL-offy,12);
Stripe_Angle = [{30} {45} {60}];

for j = 1:length(Stripe_Angle)
Stripes(j).XY = [];  
for i = 1:length(Y)
Stripes(j).XY = [Stripes(j).XY; ...
                 LandScribeV5({'S'},[{0}],{00 -Y(i)},Stripe_Angle(j),{'0*x'},{1},{1},[-1 1]*sqrt(SL^2-Y(i)^2));...
                 LandScribeV5({'T'},[{0}],{00 -Y(i)-2.5},Stripe_Angle(j),{'0*x'},{1},{1},[-1 1]*sqrt(SL^2-Y(i)^2));...
                 LandScribeV5({'T'},[{0}],{00 -Y(i)+2.5},Stripe_Angle(j),{'0*x'},{1},{1},[-1 1]*sqrt(SL^2-Y(i)^2))];
end
end
%

j = 1; 
for i2 = 1:length(Stripes)
for i1 = 1:length(EE)
Combined = [JE; EE(i1).XY; Stripes(i2).XY;]; 
[COMMAND(j).XY] = [RMS_Processor_V4(Combined,LPM_exp)];
j = j + 1;
end
end
%

[List] = RMS_RS_V3(Stripe_Angle,[{1} {-1}],{'C'},COMMAND);


%
%ObjectAutoscribeV8('ObjectDatabase.ods')
CODE = [Preface; List; PL; MLA]; %Adding Preface, Definitions, Random Statement to beginning of CODE
RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc