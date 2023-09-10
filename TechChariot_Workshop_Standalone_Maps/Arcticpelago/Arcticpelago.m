%Arcticpelago Land Generation
%TechChariot
%8.26.23

clear all
close all
clc


tic
disp(["Run Executed " datestr(clock) "..."])

filestruc = dir; %Extract a structure of the files in this directory
path = filestruc.folder; path = path(1:89); addpath(genpath(path)) %Adding functions in main folder to the path
files = {filestruc.name}; [filename] = RMS_GetLatest(files,'rms');

[Preface,LPM_exp,~] = RMS_Manual_Land(filename);

MLP = [];

%% -- Section on Islands -- %%
R   = [090];    %Radius of the Curve
THK = [090];
ISf = [{['sqrt(' num2str(R) '^2-x.^2)']}];

%ISf = [{'0.01*x.^2'}];

[ISX,ISY,dx,dy] = function_to_points_V3([ISf; {[100 000]}; {45}],[-R R],[-THK/2 THK/2],[10 10; 10 10],[10 00],[{"edge"}],[3]);

[nx,ny] = size(ISX); %Garnering the size of the point matrix

maxperdiff = 100; tol = 1;

Ht = 100; %the value of the field at the top
Hb = 000; %the value of the field at the bottom
Hl = 060; %the value of the field at the left
Hr = 000; %the value of the field at the right

H = (Ht+Hb+Hl+Hr)/4*ones(nx,ny); %initializing the general field

H(1,:)   = Ht;
H(end,:) = Hb;
H(:,1)   = Hr;
H(:,end) = Hl;

H(1,1)     = (Hr + Ht)/2;
H(1,end)   = (Hl + Ht)/2;
H(end,1)   = (Hr + Hb)/2;
H(end,end) = (Hl + Hb)/2;



while maxperdiff > tol
Hold = H; %Initialize the old value of H
  for j = 2:ny-1
    for i = 2:nx-1
      H(i,j) = 0.5*(dx(i,j)*dy(i,j))^2/(dx(i,j)^2+dy(i,j)^2)*((H(i-1,j)+H(i+1,j))/dx(i,j)^2+(H(i,j-1)+H(i,j+1))/dy(i,j)^2);
    end
    %
  end
  %
  maxperdiff = max(max(100*abs((H-Hold)./H)))
end
%

figure(1)
mesh(H')




IS.NT = 10;


IS.X = [ISX]; IS.Y = [ISY];

IS.BE = [0];
IS.TT = [{'DLC_WETROCKBEACH'}];
%IS.SS = [3];
IS.BS = [2];
%IS.Z = 1;


[LM_IS,IS] = LandScribeV6(IS,[1 1]);


%fSB = [{'0*x'} {'0.0035*x.^2'} {'0.01*x.^2'} {'-20*cos(2*pi*x/50)'} {'-10*cos(2*pi*x/50)'} {'-20*cos(2*pi*x/70)'} {'-10*cos(2*pi*x/70)'} {'20*cos(2*pi*x/70)'} {'10*cos(2*pi*x/30)'} {'18*cos(2*pi*x/50)'} {'10*cos(2*pi*x/50)'}];
%
%for i = 1:length(fSB)
%[SBX,SBY] = function_to_points_V2([fSB(i); {[75 25]}; {45}],[-75 75],[0 0],[1; 100],[0 0]); %Surge Barrier Points
%SB.X = [SBX]; SB.Y = [SBY];
%[LM_SB,~] = LandScribeV6(SB,[1 1]);
%DynamicCOMMAND(i).XY = [RMS_Processor_V6([LM_SB; LM_OS])];
%
%clear LM_SB SBX SBY
%SB.X = []; SB.Y = [];
%end
%%
%
%StaticList  = [RMS_Processor_V6([LM_LF; LM_IS])];
%[DynamicList] = RMS_RS_V2(fSB,{'C'},DynamicCOMMAND);


MLA = []; StaticList = RMS_Processor_V6([LM_IS]); DynamicList = [];

CODE = [Preface; MLP; StaticList; DynamicList; MLA]; %Adding Preface, Definitions, Random Statement to beginning of CODE

RMS_ForgeV4(filename,CODE);

disp(["Run Completed " datestr(clock) "..."])
toc


%ObjectAutoscribeV9('Arcticpelago.ods')
