function writeSCAPSscript(pathin,fileout)

fip=fopen(pathin,'w');

%comments
fprintf(fip,'//Script file made by Matlab\n');

%load files and set quit policy
fprintf(fip,'clear all\n');
fprintf(fip,'clear actions\n');
fprintf(fip,'load definitionfile PR_Cell.def\n');
fprintf(fip,'action dark\n');
% fprintf(fip,'action workingpoint.temperature %f\n',300);
% fprintf(fip,'action workingpoint.voltage %f\n',0);
% fprintf(fip,'action workingpoint.frequency %f\n',1e6);
% fprintf(fip,'action workingpoint.numberofpoints %f\n',2);
fprintf(fip,'action iv.startv %f\n',1);
fprintf(fip,'action iv.stopv %f\n',1);
fprintf(fip,'action iv.points %f\n',2);
fprintf(fip,'action iv.doiv\n');
fprintf(fip,'calculate singleshot\n');
fprintf(fip,'get energybands.efn z\n');
fprintf(fip,'get iv zu\n');
%save data
formatline = ['save scriptvariables ' fileout '\n'];
fprintf(fip,formatline);
fprintf(fip,'\n');

fclose(fip);
