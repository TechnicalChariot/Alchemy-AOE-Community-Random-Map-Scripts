%Akropole (Greek Team Acropolis) Land Generation
%TechChariot
%10.4.22

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])

str = pwd; str = str(1:102); addpath(str)
[filename] = Load_Library();
[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

MLP = []; MLA = [];

%Terrain Painting -- Glacial Sand Deposit
Span = [{1}];
Cent = [{0 0};];
Angle = [{0} {45} {90}];
%f = [{'50*sin(2*pi*x/22)'} {'50*sin(2*pi*x/29)'} {'50*sin(2*pi*x/40)'}];

f = [{'50*sin(2*pi*x/22)'}];


[nSpan] = length(Span);
[nCent,~] = size(Cent);
[~,nAngl] = size(Angle);
[~,nfunc] = size(f);

%SigMath = [{270} {0.2} {0.71} {[0 0]}]; %Signature Mathematical Parameters (necessary for any signature type) [Angular Orientation,Scale,Thickness,[x_center,y_center]]
%SigScpt = [{'DIRT'} {3}];                 %Signature Map Parameters (necessary for positive space signature) [Terrain Type, Base Elevation]

k = 0;
for i4 = 1:nSpan
for i3 = 1:nCent
for i2 = 1:nAngl
for i1 = 1:nfunc
[Preface,LPM_exp,SigComb] = RMS_Manual_Land(filename);
[River] = LandScribeV5({'NNRB'},{0},Cent(i3,:),Angle(i2),f(i1),{1},Span(i4),[-50 50]);
k = k + 1;
RawLand(k).XY = [River];
COMMAND(k).XY = RMS_Processor_V4(RawLand(k).XY,LPM_exp);
end
end
end
end
%

[List] = RMS_RS_V2(f,Angle,{'C'},COMMAND);
CODE = [Preface; MLP; List; MLA; ]; %Adding Preface, Definitions, Random Statement to beginning of CODE

RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc


%ObjectAutoscribeV8('Akropole.ods')
