%Comet_V2 Land Generation
%BPDrej
%1.31.23

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])
filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = path(1:90); addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

%off =  [45];           %Player Starting Offset Angle
%SA  =  [0];           %Player Starting Seed Angle
%b   =  [0.0];          %Player Starting team bias factor
%r   =  [10];           %Player Starting Group radius
%e   = 0.5; e = 2*e;    %Player Starting Eccentricity
%
%[create_player_lands] = RMS_CPL_V2({1},{'GRASS'},{0},off,SA,b,r,e);



##TL1 = LandScribeV5([{'GRASS'}],[{1}],{[0 0]},{45},{'0*x'},{1},{1},sqrt(2)*[-50 50]);
##TL2 = LandScribeV5([{'DIRT'}],[{1}],{[0 0]},{-45},{'0*x'},{1},{1},sqrt(2)*[-50 50]);
##TL = [TL1; TL2];



##PLI = [PLI1;PLI2;PLI3;PLI4];

##TL = []
b = 30;
ecc = 0.30;
for i=1:360
r(i,1) = b/sqrt(1-(ecc*cosd(i))^2);
x(i,1) = r(i,1)*cosd(i);
y(i,1) = r(i,1)*sind(i);
end
%
M = [x y]; CC = [62 62];
tail = LandScribeV5([{'GRASS'}],[{0}],{[0 -30]},{-45},{'0*x'},{1},{60},[-20 20;-50 50]);
TL = LandScribeV5([{'DIRT'}],[{1}],{CC},{45},{M},{1});
tag = [{'if P2'};{'elseif P4'};{'elseif P6'};{'elseif P8'};{'endif'}];
COMMAND = [];
PLI1 = LandScribeV5([{'DIRT'}],[{1}],{[00 17]},{-45},{'0*x'},{1},{0},[-18 18]);
PLI2 = LandScribeV5([{'DIRT'}],[{1}],{[00 -50]},{-45},{'0*x'},{1},{0},[-2 2]);
PLI3 = LandScribeV5([{'DIRT'}],[{1}],{[00 -50]},{-45},{'0*x'},{1},{0},[-2 2]);
PLI4 = LandScribeV5([{'DIRT'}],[{1}],{[00 -50]},{-45},{'0*x'},{1},{0},[-2 2]);
for i = 1:5
if i == 1
COMMAND = [COMMAND; tag(i)];
COMMAND = [COMMAND; RMS_Processor_V4([TL; tail],LPM_exp,[{PLI1} {PLI2} {PLI3} {PLI4}])];
elseif i == 2
COMMAND = [COMMAND; tag(i)];
PLI1 = LandScribeV5([{'DIRT'}],[{1}],{[00 1]},{-45},{'0*x'},{1},{0},[-16 16]);
PLI2 = LandScribeV5([{'DIRT'}],[{1}],{[00 30]},{-45},{'0*x'},{1},{0},[-16 16]);
COMMAND = [COMMAND; RMS_Processor_V4([TL; tail],LPM_exp,[{PLI1} {PLI2} {PLI3} {PLI4}])];
elseif i == 3
COMMAND = [COMMAND; tag(i)];
PLI1 = LandScribeV5([{'DIRT'}],[{1}],{[00 -1]},{-45},{'0*x'},{1},{0},[-16 16]);
PLI2 = LandScribeV5([{'DIRT'}],[{1}],{[00 16]},{-45},{'0*x'},{1},{0},[-20 20]);
PLI3 = LandScribeV5([{'DIRT'}],[{1}],{[00 33]},{-45},{'0*x'},{1},{0},[-16 16]);
COMMAND = [COMMAND; RMS_Processor_V4([TL; tail],LPM_exp,[{PLI1} {PLI2} {PLI3} {PLI4}])];
elseif i == 4
COMMAND = [COMMAND; tag(i)];
PLI1 = LandScribeV5([{'DIRT'}],[{1}],{[00 -1]},{-45},{'0*x'},{1},{0},[-16 16]);
PLI2 = LandScribeV5([{'DIRT'}],[{1}],{[00 10]},{-45},{'0*x'},{1},{0},[-20 20]);
PLI3 = LandScribeV5([{'DIRT'}],[{1}],{[00 22]},{-45},{'0*x'},{1},{0},[-20 20]);
PLI4 = LandScribeV5([{'DIRT'}],[{1}],{[00 33]},{-45},{'0*x'},{1},{0},[-16 16]);
COMMAND = [COMMAND; RMS_Processor_V4([TL; tail],LPM_exp,[{PLI1} {PLI2} {PLI3} {PLI4}])];
else
COMMAND = [COMMAND; tag(i)];
end
%



end
%
MLA = {['L { base_size 0 terrain_type DIRT base_elevation 1 land_position ' num2str(CC(1)) ' ' num2str(CC(2)) ' }']};


##O = [45];
##%R = 38;
##R = 30;
##S = 15;


##if i5 == 1
##[Size_List] = [size_prefix; RMS_RS_V3(O,{'C'},COMMAND)];
##else
##[Size_List] = [Size_List; size_prefix; RMS_RS_V3(O,{'C'},COMMAND)];
##end
##%



%ObjectAutoscribeV8('ObjectDatabase.ods')
CODE = [Preface; COMMAND; MLA]; %Adding Preface, Definitions, Random Statement to beginning of CODE
RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc

##k = 1;
##for j = 1:length(O)
##
##c1 = [25 25];
##c2 = [25 75];
##c3 = [75 25];
##c4 = [75 75];
##
##Y1 = (c1(:,1)-50)*sind(O(j))+(c1(:,2)-50)*cosd(O(j));
##Y2 = (c2(:,1)-50)*sind(O(j))+(c2(:,2)-50)*cosd(O(j));
##Y3 = (c3(:,1)-50)*sind(O(j))+(c3(:,2)-50)*cosd(O(j));
##Y4 = (c4(:,1)-50)*sind(O(j))+(c4(:,2)-50)*cosd(O(j));
##
##X1 = (c1(:,1)-50)*cosd(O(j))-(c1(:,2)-50)*sind(O(j));
##X2 = (c2(:,1)-50)*cosd(O(j))-(c2(:,2)-50)*sind(O(j));
##X3 = (c3(:,1)-50)*cosd(O(j))-(c3(:,2)-50)*sind(O(j));
##X4 = (c4(:,1)-50)*cosd(O(j))-(c4(:,2)-50)*sind(O(j));
##
##PLI1 = LandScribeV5([{'NNRB'}],[{1}],{[00 -Y1]},{O(j)},{'0*x'},{1},{0},X1+[-S +S]);
##PLI2 = LandScribeV5([{'NNRB'}],[{1}],{[00 -Y2]},{O(j)},{'0*x'},{1},{0},X2+[-S +S]);
##PLI3 = LandScribeV5([{'NNRB'}],[{1}],{[00 -Y3]},{O(j)},{'0*x'},{1},{0},X3+[-S +S]);
##PLI4 = LandScribeV5([{'NNRB'}],[{1}],{[00 -Y4]},{O(j)},{'0*x'},{1},{0},X4+[-S +S]);
##
##Structure(k).XY = [LandScribeV5([{'NNRB'}],[{0}],{25 25},{O(j)},{M1},{1}); ...
##                   LandScribeV5([{'WNI'}],[{0}],{25 25},{O(j)},{M2},{1}); ...
##                   LandScribeV5([{'NNRB'}],[{0}],{25 75},{O(j)},{M1},{1}); ...
##                   LandScribeV5([{'WNI'}],[{0}],{25 75},{O(j)},{M2},{1}); ...
##                   LandScribeV5([{'NNRB'}],[{0}],{75 25},{O(j)},{M1},{1}); ...
##                   LandScribeV5([{'WNI'}],[{0}],{75 25},{O(j)},{M2},{1}); ...
##                   LandScribeV5([{'NNRB'}],[{0}],{75 75},{O(j)},{M1},{1}); ...
##                   LandScribeV5([{'WNI'}],[{0}],{75 75},{O(j)},{M2},{1})];
##
##%Boundary (k).XY = [LandScribeV5([{'WNI'}],[{0}],{25 25},{O(j)},{M3},{1}); ...
##%                   LandScribeV5([{'WNI'}],[{0}],{25 75},{O(j)},{M3},{1}); ...
##%                   LandScribeV5([{'WNI'}],[{0}],{75 25},{O(j)},{M3},{1}); ...
##%                   LandScribeV5([{'WNI'}],[{0}],{75 75},{O(j)},{M3},{1})];
##%
##%
##%COMMAND(k).XY = [RMS_Processor_V4(Structure(k).XY,LPM_exp,[{PLI1} {PLI2} {PLI3} {PLI4}]); RMS_Processor_Random_Coord(Boundary(k).XY,LPM_exp,1)];
##k = k + 1;
