%Bluegill Land Generation
%TechChariot
%01.15.23

clear all
close all
clc

tic
disp(["Run Executed " datestr(clock) "..."])
filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = [path(1:89)]; addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

%%Terrain Painting --River
%Span = [{0}];
%Cent = [{0 0};];
%Angle = [{0} {90}];
%f = [{'50*sin(2*pi*x/22)'} {'50*sin(2*pi*x/29)'}];

%[nSpan] = length(Span);
%[nCent,~] = size(Cent);
%[~,nAngl] = size(Angle);
%[~,nfunc] = size(f);
%

%k = 0;
%for i4 = 1:nSpan
%for i3 = 1:nCent
%for i2 = 1:nAngl
%for i1 = 1:nfunc
%[Preface,LPM_exp,SigComb] = RMS_Manual_Land(filename);
%[River] = LandScribeV5({'B'},{0},Cent(i3,:),Angle(i2),f(i1),{1},Span(i4),[-50 50]);
%k = k + 1;
%RawLand(k).XY = [River];
%COMMAND(k).XY = RMS_Processor_V4(RawLand(k).XY,LPM_exp);
%end
%end
%end
%end
%%

[Preface,LPM_exp,SigComb] = RMS_Manual_Land(filename);

GILL_O = [LandScribeV5({'WO'},{0},{[0 +24]},{0},{'-0.04*x.^2'},{2},{1},[-20 20]); ...
          LandScribeV5({'WO'},{0},{[0 -24]},{0},{'+0.04*x.^2'},{2},{1},[-20 20])];

GILL_I = [LandScribeV5({'WI'},{0},{[0 +10]},{0},{'-0.020*x.^2'},{2},{1},[-16 16]);...
          LandScribeV5({'WI'},{0},{[0 -10]},{0},{'+0.020*x.^2'},{2},{1},[-16 16])];

GILL_CON = [LandScribeV5({'DLC_BEACH3'},{0},{[0 +20]},{90},{'-0.04*x.^2'},{2},{1},[-6 6]); ...
            LandScribeV5({'DLC_BEACH3'},{0},{[0 -20]},{90},{'+0.04*x.^2'},{2},{1},[-6 6])];

RING = [];

for i = 1:360
RING = [RING; LandScribeV5({'GRASS'},{1},{[0 0]},{i},{['0*x']},{1},{0},(1+40*abs(sind(i))/360)*[33 33])];
end
%

RawLand = [GILL_CON; GILL_O; GILL_I; RING];

COMMAND = RMS_Processor_V4(RawLand,LPM_exp);
List = COMMAND;

G = []; C = [];

r = [32]; off = [45]; adc = [180]; SA  = [90]; b  = [0]; ecc = [1];
G = [{r}; {off}; {adc}; {SA}; {b}; {ecc}];


BE = 1; BS = 7; LP = 0; ZA = 0; delta = 0;
C = [{BE}; {BS}; {LP}; {ZA}; {delta}];

[create_player_lands] = RMS_CPL_V7(G,C);

%[List] = RMS_RS_V3(f,Angle,{'C'},COMMAND);
CODE = [Preface; List; create_player_lands]; %Adding Preface, Definitions, Random Statement to beginning of CODE
RMS_ForgeV4(filename,CODE);


%ObjectAutoscribeV8('ObjectDatabase.ods')

disp(["Run Completed " datestr(clock) "..."])
toc
