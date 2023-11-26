## Copyright (C) 2021 ThorsChariot
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} LandScribeFunction (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: ThorsChariot
## Created: 2021-03-11

function [D,E,F,G] = LandScribeV6(varargin)




%Combined = [{} {} {} {}];
%terrain_type    = varargin{1}; %Declaration of the type of terrain to be painted
%base_elevation  = varargin{2}; %Declaration of the elevation of that terrain. Should be a 2x1 matrix with [starting,ending] elevation
%CEN             = varargin{3}; %Extracts the central point of the shape as the third input
%O               = varargin{4}; %Rotation Angle of the Shape Around its OWN center(not map center)
%Y               = varargin{5}; %Declared either 1) set of datapoints of 2) a string as the function for those datapoints.
%t      = cell2mat(varargin{6}); %Extracts the thickness of the brush as the sixth input
%
%CEN = cell2mat(CEN); %Converting from cell input
%Y = Y{1}; O = O{1};
%
%%If Y is an anonymous function, then the following additional inputs are required:
%
%if isa(Y,'char')
%THK      = cell2mat(varargin{7}); %Extracts the total thickness of the shape as the seventh input
%xlimit   = varargin{8}; %Extracts the range of x allowed. Required for function input.
%[xlimit] = rectfix(xlimit); %Fix the xlimits to be matrix (if required)
%
%  if     nargin == 8
%  ylimit = [-Inf Inf];  %Since no range of ylimits was provided, assume any y value is allowed
%  elseif nargin == 9
%  ylimit = varargin{9}; %Extracts the range of y allowed. Optional for function input.
%  end
%%
%[Data,App] = CommandLines(terrain_type,base_elevation,CEN,Y,t,THK,xlimit,ylimit);
%[Data,App] = RotateAndTrim(Data,App,O); %Rotating this particular line
%[nx,~] = size(Data);
%else
%%[nx,~] = size(Y); %Finding the size of the input for matrix type
%[Data] = PointSelect(Y,t); %Selecting points within thickness t from actual curve
%
%%pkg load io
%%xlswrite('diagnosis5',Y)
%%xlswrite('diagnosis6',Data)
%
%[Data] = RotateAndTrimSimple(Data,CEN,O);
%
%[nx,~] = size(Data); %updating to the new size after transformation
%
%temp_terrain_type = terrain_type{1}; temp_terrain_elev = base_elevation{1}; %Only take the first in the vector
%
%for i = 1:nx
%Data(i,:) = [Data(i,1) Data(i,2)]; App(i,:) = [{temp_terrain_type} {temp_terrain_elev}];
%end
%%
%
%
%end
%%
%
%for i = 1:nx
%Combined(i,:) = [Data(i,1) Data(i,2) {App(i,1)} {App(i,2)}] ;
%%Combined(i,:) = [Data(i,1) {Data(i,2)} {App(i,1)} {App(i,2)}];
%end
end
%

function [ULeft,URight] = CommandLines(terrain_type,base_elevation,Cent,f,t,THK,xlimit,ylimit)
%Inputs Are:
%terrain_type   -- The type of terrain to be painted. This should be a vector of cell entries whose contents are
%the string match for an AOE2 DE terrain. If this vector is two or more entries long, then the function will paint
%the first terrain (first entry) and transition into the others proportionate to the number of times they are
%repeated in the vector as well as the overall vector length. For example, if this function received the vector:
%terrain_type = [{'GRASS'} {'GRASS'} {'GRASS_SNOW'} {'GRASS_SNOW'} {'SNOW'}]
%Then the first 40% of the land painted would be grass, the next 40% would be snowy grass, and the remaining 20% would be snow
%base_elevation -- A vector containing the elevations of the land to be painted. Has the same structure as "terrain_type",
%and functions with the same proportionate setup. Numbers should be integers between 0 and 7, inclusive.
%f              -- The function (as a string), which should be general character. Do not try to control offset here
%Cent           -- The center of the shape relative to the absolute center of the map, Point (50,50). Should be a 2x1 vector.
%THK            -- The total thickness of the shape (top end to bottom). A simple scalar.
%xlimit         -- A matrix representing minimum and maximum values of x, both before and after sweeping function "f".
%ylimit         -- A vector represending minimum and maximum values of y.

%Outputs Are:
%ULeft          -- A compiled matrix of coordinates for all y-offsets, whose rows are [x_coord,y_coord]
%URight         -- A compiled matrix of corresponding terrain information, whose rows are: [{terrain_type},{base_elevation}]

[f] = AbsXOffset(f,Cent(1)); %Modify each instance of x in function f with offset specified in string format
v = [-floor(THK/2):t:ceil(THK/2)]+Cent(2); %form a vector of vertical offsets to add to function "f"
nv = length(v); %Find the length of the vector of vertical offsets

vect_terrain_type = round(linspace(1,length(terrain_type),nv));     %Expanding a vector of the number of terrain types
vect_terrain_elev = round(linspace(1,length(base_elevation),nv)); %Expanding a vector of the terrain elevations

vect_xlimit_min = round(linspace(xlimit(2,1),xlimit(1,1),nv));      %Expanding a vector of minimum xlimit values (from bottom)
vect_xlimit_max = round(linspace(xlimit(2,2),xlimit(1,2),nv));      %Expanding a vector of minimum xlimit values (from bottom)

for k = 1:nv %Generating a set of points for every y offset
temp_terrain_type      = terrain_type(vect_terrain_type(k));             %Selecting Entry of Terrain Type

temp_terrain_elev      = cell2mat(base_elevation(vect_terrain_elev(k))); %Selecting Elevation

alt_elev_vect = [0:max(temp_terrain_elev)]; %Alternative elevation vector to allow gradual rise from edges

temp_xlimit_min = vect_xlimit_min(k); %Selecting minimum xlimit to use
temp_xlimit_max = vect_xlimit_max(k); %Selecting maximum xlimit to use
x = [floor(temp_xlimit_min):0.05:ceil(temp_xlimit_max)]'; %produce array of independent variable

disp(["Executing command line generation for " char(temp_terrain_type) " on the curve y = " f "+" num2str(v(k)) " at elevation " mat2str(temp_terrain_elev) " bounded from x = [" num2str(min(xlimit)) "," num2str(max(xlimit)) "], y = [" num2str(min(ylimit)) "," num2str(max(ylimit)) "]"])
Y(k) = {str2func(['@(x) ' f '+' mat2str(v(k))])};                 %Generating Function for given offset
y = Y{k}; %coaxing out raw anonymous function

M = [x y(x)]; M = M(M(:,2) <= max(ylimit),:); M = M(M(:,2) >= min(ylimit),:); %removing points corresponding to y outside limits
[P] = PointSelect(M,t); %Selecting points within thickness t from actual curve

[nx,~] = size(P);
for i = 1:nx %Populating full data matrix with terrain type and elevation. First cell contains string of coordinate
DataLeft(i,:) = [P(i,1) P(i,2)];
%if abs(P(i,1) - max(P(:,1))) <= floor(temp_terrain_elev/2) || abs(P(i,1) - min(P(:,1))) <= floor(temp_terrain_elev/2)
%DataRight(i,:) = [{temp_terrain_type} {0}];
%else
DataRight(i,:) = [{temp_terrain_type} {temp_terrain_elev}];
%end
end
%

if k == 1  %Conditional about adding to compiled matrix
NLeft = DataLeft; NRight = DataRight;
else
NLeft = [NLeft; DataLeft]; NRight = [NRight; DataRight];
end
%

end
%

[~,ia,ic] = unique(NLeft,'rows'); %Finding unique position indices among entire swept shape
ULeft = NLeft(ia,:); URight = NRight(ia,:); %Limiting the resulting matrices to those unique indices
end
%
function [Data] = PointSelect(M,t)
%This function finds all coordinate points within thickness "t" of the specified x and y points.
x = M(:,1); y = M(:,2);
y_der = gradient(y)./gradient(x); %find numerical derivative
%y_der
for i = 1:length(y_der)
if isnan(y_der(i))
dx(i,1) = t/sqrt(2);
dy(i,1) = 0;
elseif y_der(i) == 0
dx(i,1) = 0;
dy(i,1) = t/sqrt(2);
else
dy(i,1) = t/sqrt(2)/(1+abs(y_der(i)));
dx(i,1) = t/sqrt(2) - dy(i,1);
end
end
%
xwind = [round(x-dx) round(x+dx)]; ywind = [round(y-dy) round(y+dy)]; %establishing window matrices

wind = [xwind ywind];
wind = unique(wind,'rows');
[nx,~] = size(wind);

float = 0; %initialize floating index
for k = 1:nx
jvect = min(wind(k,3:4)):0.25:max(wind(k,3:4));
ivect = min(wind(k,1:2)):0.25:max(wind(k,1:2));
for j = jvect
for i = ivect
      float = float + 1;
      Data(float,:) = [i j];
end
end
%
end
%
Data = unique(Data,'rows');
end
%

function [xlimit] = rectfix(xlimit)
%Format for xlimit should be:
%xlimit = [x1 x2; x3 x4]
%Where x1 is the minimum x value on the top    edge of the shape, marking the top    left  corner
%Where x2 is the maximum x value on the top    edge of the shape, marking the top    right corner
%Where x3 is the minimum x value on the bottom edge of the shape, marking the bottom left corner
%Where x4 is the maximum x value on the bottom edge of the shape, marking the bottom right corner
%If x3 = x1 and x4 = x2 (the case of a rectangle), then the user might have simply specified that
%xlimit = [x1 x2], and this function will correct that. Note that x1 need not equal x3 nor x2 equal x4.
[nx,~] = size(xlimit);
if nx == 1
xlimit = [xlimit; xlimit];
else
end
end
%
function [f] = AbsXOffset(f,x0)
if x0 > 0
str_add = ['(x-' num2str(x0) ')'];
elseif x0 < 0
str_add = ['(x+' num2str(-x0) ')'];
else
end
%
if x0 ~= 0
i = 1; lsa = length(str_add);
while i <= length(f)
if f(i) == 'x'
str_bef = f(1:i-1); str_aft = f(i+1:end);
f = [str_bef str_add str_aft];
i = i + lsa;
else
i = i + 1;
end
end
end
end
%
