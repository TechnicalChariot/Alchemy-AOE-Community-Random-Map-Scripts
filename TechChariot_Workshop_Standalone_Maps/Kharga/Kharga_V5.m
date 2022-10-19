%Kharga Land Generation V2
%ThorsChariot
%5.14.21

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])


str = pwd; str = str(1:102); addpath(str)
[filename] = Load_Library();

%Generating Mountain Data
[Mountain1] = LandScribeV5([{'D'} {'Q'} {'Q'}],[{1} {7} {7} {4} {4} {4}],{0 62},{045},{['0.02*x.^2']},{2},{12},[-50 50]); %Mountain 1
[Mountain2] = LandScribeV5([{'D'} {'Q'} {'Q'}],[{1} {7} {7} {4} {4} {4}],{0 62},{135},{['0.02*x.^2']},{2},{12},[-50 50]); %Mountain 2
[Mountain3] = LandScribeV5([{'D'} {'Q'} {'Q'}],[{1} {7} {7} {4} {4} {4}],{0 62},{225},{['0.02*x.^2']},{2},{12},[-50 50]); %Mountain 3
[Mountain4] = LandScribeV5([{'D'} {'Q'} {'Q'}],[{1} {7} {7} {4} {4} {4}],{0 62},{315},{['0.02*x.^2']},{2},{12},[-50 50]); %Mountain 4
Mountain = [Mountain1; Mountain2; Mountain3; Mountain4];

%Generating Sand Dunes
[Base] = LandScribeV5([{'D'}],{0},{0 0},{0},{'0*x'},{2},{100},[-50 50]); %Base Terrain
Base = checkering(Base,[0 2]); %performing checkering of base terrain

%Angular Orientation of Various Shapes
Angle = [{0}; {90}];

%Oasis Basic Parameters
r  = [{0.3}; {0.4}];     %Aspect Ratio of the Oasis

Oasis_Terrain = [{'B'} {'B'} {'B'} {'B'} {'B'} {'B'} ...
                 {'B'} {'B'} {'B'} {'B'} {'B'} {'B'} ...
                 {'B'} {'B'} ...
                 {'M'} {'M'} {'M'} {'M'} {'M'} {'M'}...
                 {'Y'} {'Y'}  {'Y'} {'Y'} {'Y'} {'Y'}...
                 {'T'} {'T'} {'T'} {'T'}];

j = 1;
for i2 = 1:length(r)
for i1 = 1:length(Angle)
na = length(Oasis_Terrain);
S = 2;   %Spacing Between Layers
amax = S*na + 1;
amin = amax-S*na;
a = [amin:S:amax];

if Angle{i1} == 0
SigMath1 = [{000} {0.25} {0.71} {[50 14]}]; %Signature Mathematical Parameters (necessary for any signature type) [Angular Orientation,Scale,Thickness,[x_center,y_center]]
SigMath2 = [{180} {0.25} {0.71} {[50 86]}]; %Signature Mathematical Parameters (necessary for any signature type) [Angular Orientation,Scale,Thickness,[x_center,y_center]]
elseif Angle{i1} == 90
SigMath1 = [{270} {0.25} {0.71} {[14 50]}]; %Signature Mathematical Parameters (necessary for any signature type) [Angular Orientation,Scale,Thickness,[x_center,y_center]]
SigMath2 = [{090} {0.25} {0.71} {[86 50]}]; %Signature Mathematical Parameters (necessary for any signature type) [Angular Orientation,Scale,Thickness,[x_center,y_center]]
end
%

[Preface,LPM_exp1,SigComb] = RMS_Manual_Land(filename,SigMath1);
[Preface,LPM_exp2,SigComb] = RMS_Manual_Land(filename,SigMath2);

LPM_exp = [LPM_exp1; LPM_exp2];

R = [{}];
for i = 1:na
f1 = [{['-' mat2str(r{i2}) '*sqrt(' mat2str(a(i)) '^2 - x.^2)']}]; %Function 1
f2 = [{[    mat2str(r{i2}) '*sqrt(' mat2str(a(i)) '^2 - x.^2)']}]; %Function 2
[R1] = LandScribeV5(Oasis_Terrain(i),{0},{0 0},Angle(i1),f1,{1},{1},[-a(i) a(i)]); %Ring 1
[R2] = LandScribeV5(Oasis_Terrain(i),{0},{0 0},Angle(i1),f2,{1},{1},[-a(i) a(i)]); %Ring 2
R = [R; R1; R2] ;
end
%

RawLand = [R; Mountain; Base];
[cpl] = RMS_CPL_V6({1},{1},{0},[43 45 47],[175 180 185],Angle{i1},[0],[0.9*max(a)],2*r{i2}*0.70); %creating player lands


Combined = [SigComb; RawLand];
[COMMAND(j).XY] = [RMS_Processor_V4(Combined,LPM_exp); cpl];

%
j = j + 1;
end
end
%

[List] = RMS_RS_V2(Angle,r,{'C'},COMMAND);

CODE = [Preface; List]; %Adding Preface, Definitions, Random Statement to beginning of CODE

RMS_ForgeV4(filename,CODE);
%ObjectAutoscribeV8('Kharga_V5.ods')
disp(["Run Completed " datestr(clock) "..."])
toc
%SigScpt = [{'BT'} {0}];                 %Signature Map Parameters (necessary for positive space signature) [Terrain Type, Base Elevation]
