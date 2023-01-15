%Bluegill Land Generation
%TechChariot
%01.15.23

clear all
close all
clc

tic
disp(["Run Executed " datestr(clock) "..."])
filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = [path(1:126) 'Functions']; addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

%%Terrain Painting --River
Span = [{0}];
Cent = [{0 0};];
Angle = [{0} {90}];
f = [{'50*sin(2*pi*x/22)'} {'50*sin(2*pi*x/29)'}];

[nSpan] = length(Span);
[nCent,~] = size(Cent);
[~,nAngl] = size(Angle);
[~,nfunc] = size(f);
%

k = 0;
for i4 = 1:nSpan
for i3 = 1:nCent
for i2 = 1:nAngl
for i1 = 1:nfunc
[Preface,LPM_exp,SigComb] = RMS_Manual_Land(filename);
[River] = LandScribeV5({'B'},{0},Cent(i3,:),Angle(i2),f(i1),{1},Span(i4),[-50 50]);
k = k + 1;
RawLand(k).XY = [River];
COMMAND(k).XY = RMS_Processor_V4(RawLand(k).XY,LPM_exp);
end
end
end
end
%

[List] = RMS_RS_V3(f,Angle,{'C'},COMMAND);
CODE = [Preface; List]; %Adding Preface, Definitions, Random Statement to beginning of CODE
RMS_ForgeV4(filename,CODE);


%ObjectAutoscribeV8('ObjectDatabase.ods')

disp(["Run Completed " datestr(clock) "..."])
toc
