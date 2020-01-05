function writeSCAPSscript_edited(pathin,fileout)

fip=fopen(pathin,'w');

%comments
fprintf(fip,'//Script file made by Matlab\n');

%load files and set quit policy
fprintf(fip,'set quitscript.quitSCAPS\n');
fprintf(fip,'load allscapssettingsfile MatlabExample.scaps\n');

%change parameters
fprintf(fip,'set layer1.Eg %f\n',1);
%calculate
fprintf(fip,'calculate\n');
%get data into vectors x and y
fprintf(fip,'get iv xy\n');
%change parameters
fprintf(fip,'set layer1.Eg %f\n',1);
%calculate
fprintf(fip,'calculate\n');
%get data into vectors z and u
fprintf(fip,'get iv zu\n');

%save data
formatline = ['save scriptvariables ' fileout '\n'];
fprintf(fip,formatline);
fprintf(fip,'\n');


fclose(fip);
