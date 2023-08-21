%Arcticpelago Land Generation
%TechChariot
%4.23.23

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])

filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = path(1:89); addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

MLP = []; f = [{'0.005*x.^2'}];
%f = [{'0*x'}; {'0.010*x.^2'}; {'-0.010*x.^2'}];


[IsX,IsY] = function_to_points_V2([f; {[50 50]}; {45}],[-50 50],[-15 15],[10; 14],[0 0]);

%figure(1)
%plot(IsX,IsY,'x')
%grid minor
%axis equal


%for i = 1:length(O)
%if i == 1
%[IsX,IsY] = function_to_points([f(1); {c}; {O(i)}],[{V}; {n}]);
%else
%[IsXn,IsYn] = function_to_points([f(1); {c}; {O(i)}],[{V}; {n}]);
%IsX = [IsX; IsXn]; IsY = [IsY; IsYn];
%end
%end
%%

Is.TT = [{'WRB'}]; Is.BS = [3];
Is.X = [IsX]; Is.Y = [IsY];
Is.NT = 100;

[LM_Is,Is] = LandScribeV6(Is,[1 1]); List = [RMS_Processor_V6(LM_Is)];



MLA = [];



CODE = [Preface; MLP; List; MLA]; %Adding Preface, Definitions, Random Statement to beginning of CODE

RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc


%ObjectAutoscribeV8('GitcheeGumee.ods')
