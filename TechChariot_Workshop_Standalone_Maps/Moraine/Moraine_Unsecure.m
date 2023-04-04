%Moraine Land Generation
%ThorsChariot
%1.27.21

clear all
close all
clc

disp("Run Executed...")

%File Under Construction
filename = 'Moraine_Unsecure.rms';


%%Terrain_Painting -- Bilateral Mountain Generation
terrain_type    = 'GRAVEL';
number_of_tiles = 1;
n = 40; %number of datapoints
base_elevation  = round(linspace(1,7,n))';
base_size       = 2*ones(n,1);

Offset = linspace(10,-45,n)';
Angle = [225]';

x = linspace(-100,100,2000);
y = 200*exp(-x.^2/200);

%%Generating Bilateral Slopes
for k = 1:length(Offset)
STRUC(k).XY = Land_Scribe([x',y'],terrain_type,number_of_tiles,base_elevation(k,1),base_size(k,1),Offset(k,1),Angle);
if k == 1
Slopes = STRUC(k).XY; 
else
Slopes = [Slopes; STRUC(k).XY];
end
%
end
%
clear STRUC

%%Generating Glacial Edge
terrain_type    = 'ICE';
number_of_tiles = 1;
base_elevation  = 0;
base_size       = 5;
n = 20;
Offset = linspace(-60,0,n)';
Angle = [225]';

T = 200;
Range = linspace(10,15,n)';

for k = 1:length(Offset)
if k == length(Offset)
Range(k,1) = max(Range) - 3;
terrain_type    = 'DIRT';
base_size       = 3;
end
%

x = linspace(-Range(k,1),Range(k,1),100);
y = -40*cos(2*pi*x/T);
STRUC(k).XY = Land_Scribe([x',y'],terrain_type,number_of_tiles,base_elevation,base_size,Offset(k,1),Angle);
if k == 1
Glacier = STRUC(k).XY; 
else
Glacier = [Glacier; STRUC(k).XY];
end
%
clear x
clear y
end
%

%%Painting the Moraine
terrain_type    = 'DLC_DIRT4';
number_of_tiles = 1;
base_elevation  = 0;
base_size       = 3;

Offset = 32;
Angle = [225]';

T = 200;
Range = 20;

x = linspace(-Range,Range,200);
y = -40*cos(2*pi*x/T);
Moraine_Creation = Land_Scribe([x',y'],terrain_type,number_of_tiles,base_elevation,base_size,Offset,Angle);

%%Terrain Painting -- Glacial Sand Deposit

terrain_type    = 'DLC_QUICKSAND';
number_of_tiles = 1;
base_elevation  = 0;
base_size       = 2;

Offset = linspace(-10,10,30)';
Angle = [225]';

Range = 20;

x = linspace(-Range,Range,20);
y = -0.05*x.^2;
for k = 1:length(Offset)
STRUC(k).XY = Land_Scribe([x',y'],terrain_type,number_of_tiles,base_elevation,base_size,Offset(k,1),Angle);
if k == 1
Sand_Deposit = STRUC(k).XY; 
else
Sand_Deposit = [Sand_Deposit; STRUC(k).XY];
end
%
end
%


%%Terrain Painting -- Drainage River

terrain_type    = 'DIRT';
number_of_tiles = 1;
base_elevation  = 0;
base_size       = 3;

Offset = linspace(0,15,40)';
Angle = [225]';

Range = 20;

x = 0;
y = x;

for k = 1:length(Offset)
STRUC(k).XY = Land_Scribe([x',y'],terrain_type,number_of_tiles,base_elevation,base_size,Offset(k,1),Angle);
if k == 1
Drainage_River = STRUC(k).XY; 
else
Drainage_River = [Drainage_River; STRUC(k).XY];
end
%
end
%

%%Painting Seabed
terrain_type    = 'BEACH';
number_of_tiles = 1;
base_elevation  = 0;
base_size       = 3;

Offset = linspace(34,50,40)';
Angle = [225]';

T = 200;
Range = 26;

x = linspace(-Range,Range,120);
y = -40*cos(2*pi*x/T);

for k = 1:length(Offset)
STRUC(k).XY = Land_Scribe([x',y'],terrain_type,number_of_tiles,base_elevation,base_size,Offset(k,1),Angle);
if k == 1
Beach = STRUC(k).XY; 
else
Beach = [Beach; STRUC(k).XY];
end
%
end
%


%%Painting Monastic Outcropping
terrain_type    = 'SNOW_STRONG';
number_of_tiles = 1;
base_elevation  = 4;
base_size       = 4;

Offset = -48;
Angle = [225]';

T = 200;
Range = 20;

x = 0;
y = 0;
Monastic_Outcropping = Land_Scribe([x',y'],terrain_type,number_of_tiles,base_elevation,base_size,Offset,Angle);



%% Painting Starting Land (COMMAND LINES)
Starting_Lands = ...
[{'create_land'}; 
{'{'};
{'terrain_type ROAD'}  ;
{'assign_to_player 2'};
{'land_id 2'};
{'land_position 0 0'};
{'number_of_tiles 1'};
{'base_elevation 4'};
{'}'};

{'create_land'}; 
{'{'};
{'terrain_type ROAD'}  ;
{'assign_to_player 4'};
{'land_id 4'};
{'land_position 0 1'};
{'number_of_tiles 1'};
{'base_elevation 4'};
{'}'};

{'create_land'}; 
{'{'};
{'terrain_type ROAD'}  ;
{'assign_to_player 6'};
{'land_id 6'};
{'land_position 1 0'};
{'number_of_tiles 1'};
{'base_elevation 4'};
{'}'};

{'create_land'}; 
{'{'};
{'terrain_type ROAD'}  ;
{'assign_to_player 8'};
{'land_id 8'};
{'land_position 1 1'};
{'number_of_tiles 1'};
{'base_elevation 4'};
{'}'};

{'create_land'}; 
{'{'};
{'terrain_type ROAD'}  ;
{'assign_to_player 1'};
{'land_id 1'};
{'land_position 99 99'};
{'number_of_tiles 1'};
{'base_elevation 4'};
{'}'};

{'create_land'}; 
{'{'};
{'terrain_type ROAD'}  ;
{'assign_to_player 3'};
{'land_id 3'};
{'land_position 99 98'};
{'number_of_tiles 1'};
{'base_elevation 4'};
{'}'};

{'create_land'}; 
{'{'};
{'terrain_type ROAD'}  ;
{'assign_to_player 5'};
{'land_id 5'};
{'land_position 98 99'};
{'number_of_tiles 1'};
{'base_elevation 4'};
{'}'};

{'create_land'}; 
{'{'};
{'terrain_type ROAD'}  ;
{'assign_to_player 7'};
{'land_id 7'};
{'land_position 98 98'};
{'number_of_tiles 1'};
{'base_elevation 4'};
{'}'};
];

%Starting_Lands = ...
%[{'create_land'}; 
%{'{'};
%{'terrain_type ROAD'}  ;
%{'assign_to_player 2'};
%{'land_id 2'};
%{'land_position 0 0'};
%{'number_of_tiles 1'};
%{'base_elevation 4'};
%{'}'};
%
%{'create_land'}; 
%{'{'};
%{'terrain_type ROAD'}  ;
%{'assign_to_player 4'};
%{'land_id 4'};
%{'land_position 0 1'};
%{'number_of_tiles 1'};
%{'base_elevation 4'};
%{'}'};
%
%{'create_land'}; 
%{'{'};
%{'terrain_type ROAD'}  ;
%{'assign_to_player 6'};
%{'land_id 6'};
%{'land_position 1 0'};
%{'number_of_tiles 1'};
%{'base_elevation 4'};
%{'}'};
%
%{'create_land'}; 
%{'{'};
%{'terrain_type ROAD'}  ;
%{'assign_to_player 8'};
%{'land_id 8'};
%{'land_position 1 1'};
%{'number_of_tiles 1'};
%{'base_elevation 4'};
%{'}'};
%
%{'create_land'}; 
%{'{'};
%{'terrain_type ROAD'}  ;
%{'assign_to_player 1'};
%{'land_id 1'};
%{'land_position 100 100'};
%{'number_of_tiles 1'};
%{'base_elevation 4'};
%{'}'};
%
%{'create_land'}; 
%{'{'};
%{'terrain_type ROAD'}  ;
%{'assign_to_player 3'};
%{'land_id 3'};
%{'land_position 100 99'};
%{'number_of_tiles 1'};
%{'base_elevation 4'};
%{'}'};
%
%{'create_land'}; 
%{'{'};
%{'terrain_type ROAD'}  ;
%{'assign_to_player 5'};
%{'land_id 5'};
%{'land_position 99 100'};
%{'number_of_tiles 1'};
%{'base_elevation 4'};
%{'}'};
%
%{'create_land'}; 
%{'{'};
%{'terrain_type ROAD'}  ;
%{'assign_to_player 7'};
%{'land_id 7'};
%{'land_position 99 99'};
%{'number_of_tiles 1'};
%{'base_elevation 4'};
%{'}'};
%];



COMMAND = [Beach; Sand_Deposit; Glacier; Slopes; Moraine_Creation; Drainage_River; Monastic_Outcropping; Starting_Lands];



RMS_Forge(filename,COMMAND)
clc
disp('All Done!!! :D')