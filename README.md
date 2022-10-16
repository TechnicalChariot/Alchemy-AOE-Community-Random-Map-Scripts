Age of Empires II: Definitive Edition (AOE2:DE)
Collaborative Random Map Scripting (RMS) Project

TechChariot#4776
QFilip#7594


Introduction:

Welcome to the AOE2:DE RMS Collaboration project! This repository is intended to be a comprehensive library of custom Random Map Scripts, maintaned as an archive, and the source for an in-game mod of the same name. Since it is based in GitHub, any scripts shared through the repository are monitored for changes, which is useful for code review and collaboration, but can involve additional responsibilities. To help us make sure that this repository is productive for everyone, please observe the guidelines below.

Guidelines:

1) NUMBER OF RMS FILES PER COLLABORATOR -- If you follow the configuration instructions below, then this Github repository will be configured to appear in a folder monitored by your game for the presence of .rms "Random Map Script" files. This means that any .rms file shared through this respository will be detected by your locally installed game, featured in the scenario editor:

![image](https://user-images.githubusercontent.com/115369420/195188704-9df23df3-3f3d-45f6-8793-ebef0d36fb38.png) 

and in lobby custom map selection:
 
![image](https://user-images.githubusercontent.com/115369420/195189829-b59a3e71-a014-4c81-89aa-602594adca95.png). 

However, in addition to seeing your own work, you will also see the .rms files shared by everyone else in the same location. This enables collaboration, but since this Github repository is intended to host hundreds or even thousands of scripts, to share them all as .rms files would be counterproductive due to the difficulty in finding the right map in game. For this reason, the number of *collaborative* files in this archive is limited to *one* per person. In other words, each collaborator may own up to one .rms file in the repository at any given time. There is no limit to the number of other files a collaborator may own, since these files are not detected by the game and will not clutter the interfaces of other random map developers.

2) OTHER TYPES OF FILES/FILE STRUCTURE -- Most of the data stored in this repository takes the form of text files with .si ("Script Inactive") extension. These files are identical in content to a finished .rms ("Random Map Script") file, except they are not recognized by the game. They are, however, still readable by the auto-mod application, which will convert them into .rms and save them somewhere else, to be published to the game as a mod or mods intended for the players to subscribe to and enjoy. To create a .si file from .rms, one can simply change the extension in file explorer. Since it is a text file, the data stored in the file will be preserved. It is recommended that collaborators use the included spreadsheet and .m file to activate/deactive scripts programmatically, but this is not necessary if all the files shared are .si type. Other files that could be shared with a .rms or .si include spreadsheets for calculations, .png or .jpeg images of the map, or .m files for GNU Octave script compilers. Regardless of whether or not your script has any accompanying files, follow the existing file structure and share it only within its own subfolder. For example, .../YourScript/YourScript.rms or .../YourScript/YourScript.si. That way, we don't have random files kicking around the repository. All scripts shared in this repository must have a primary creator, so if you do not yet have your own subfolder (as the first layer within the repository), then make one. All subfolders containing your creations will go in this main folder. 

3) PERMISSION TO SHARE: -- By uploading content to our Github Repository, you are agreeing that we can share your .si files (converted to .rms for the players, obviously) through an AOE2:DE mod/mods, fully crediting your amazing work, and bragging about how lucky we are to know and work with you. 

Configuration Instructions:

1) Create a free Github Account by going to the following website: https://github.com/, clicking on the button below and following the  prompts/instructions:
![image](https://user-images.githubusercontent.com/115369420/194990488-0ea840ee-bf04-4c92-a261-27658236f0cb.png)

2) Configure Github to your desktop by going to the following website: https://desktop.github.com/ and clicking on the button below:
![image](https://user-images.githubusercontent.com/115369420/194990520-1cbc95de-5c1d-4797-9a88-ccd5df84eebb.png)

3) Visit the working directory for AOE2 map scripts: C:\Program Files (x86)\Steam\steamapps\common\AoE2DE\resources_common\random-map-scripts
In its unmodified state, this directory will contain the original Ensemble Studios map scripts:
![image](https://user-images.githubusercontent.com/115369420/194990628-ddad0474-db8e-466c-9363-1116ea14971a.png)
Move these scripts to their own subfolder or delete them:
![image](https://user-images.githubusercontent.com/115369420/194990722-2f4b7907-fb7f-4294-a4c0-cd83ba10518f.png)
This is necessary because if it is not done, an error will be thrown when attempting to clone the Github repository to this location:
![image](https://user-images.githubusercontent.com/115369420/194990782-6b77ae3d-06e7-48cf-9cd6-609fa173c44f.png)
At this time, you can create other folders in this location. For example, here is a directory configured with a “My_Workshop” folder that will not be monitored by Github. This is useful for private scripts/projects that you don’t want to share with the world: 
![image](https://user-images.githubusercontent.com/115369420/194990849-53918569-bc76-4286-aa11-2d7da6ecffb9.png)

4) Launch Github desktop and select the following “Clone Repository from the Internet”:
![image](https://user-images.githubusercontent.com/115369420/194990918-7d129d19-210f-44ab-84da-dec0d58a61a7.png)

5) Select URL tab (furthest right):
![image](https://user-images.githubusercontent.com/115369420/194991629-52762be0-5041-495f-934e-f9ff5f8d6bb2.png)
Type in the following URL: https://github.com/TechnicalChariot/Age-of-Empires-II-Definitive-Edition----Random-Map-Scripts
Make sure that your Local path is set to: C:\Program Files (x86)\Steam\steamapps\common\AoE2DE\resources\_common\random-map-scripts 
Hit “Clone”:
![image](https://user-images.githubusercontent.com/115369420/194993244-b59f61aa-80eb-4619-accc-83f44185efda.png)
  
6) A few loading screens will process, and when completed, you should be able to visit:  C:\Program Files (x86)\Steam\steamapps\common\AoE2DE\resources_common\random-map-scripts and confirm that an additional folder called “Age-of-Empires-II-Definitive-Edition----Random-Map-Scripts” has been added:
![image](https://user-images.githubusercontent.com/115369420/194993716-a83da5d6-69d8-49f6-80fc-866a374c8484.png)
Any folders or files you add to this folder will be tracked by Github and visible to any other collaborators of the repository. Happy scripting!
