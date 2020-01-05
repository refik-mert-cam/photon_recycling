%%% KD, ELIS Ugent 5-5-2011
%%% This is an example file illustrating how to handle SCAPS using Matlab
%%% Feel free to change it according to your own needs
%%% There are two daugther functions:
%%% readSCAPSscriptresults: this function should not be edited, it reads the resulting file from SCAPS
%%% writeSCAPSscript: this function makes a SCAPS script-file, change this according to your own needs

%%% The current example uses the results only to plot data, but of course you can do with it everything which is possible in Matlab
%%% The current example only launches SCAPS once, but of course you can
%%% launch SCAPS several times
%%% Take care to change the used paths to your own paths


clear all; %comment this line out if you want to be able to set breakpoints

%%% CHANGE THE BELOW TWO LINES %%%
SCAPSfolder = 'C:\Koen\Scaps\SCAPS_3101_werkversie';%your local SCAPS folder !!!MAKE SURE THERE ARE NO SPACES IN YOUR SCAPS PATH, THIS IS A MATLAB ISSUE :-(
SCAPSversion = 'scaps3101.exe'; %your SCAPS version !!!also avoid spaces here

%set filenamess
scriptfile = 'MatlabScript.script';
outputfile = 'scriptMatlabResults.xls';

%write script
scriptpath = [SCAPSfolder '\script\' scriptfile];
writeSCAPSscript(scriptpath,outputfile);

%execute SCAPS
orderToSCAPS = ['! ' SCAPSfolder '\' SCAPSversion ' ' scriptfile];
eval(orderToSCAPS);

%read in results
pathname = [SCAPSfolder '\results\' outputfile];
result = readSCAPSscriptresults(pathname);

% the results are in the result structure

% plot the results
xdata = result.data(1:result.dimensions(1),1);%x
ydata = result.data(1:result.dimensions(2),2);%y
xxdata= result.data(1:result.dimensions(3),3);%z
yydata= result.data(1:result.dimensions(4),4);%u
figure;
plot(xdata,ydata,'b.-');
hold on;
plot(xxdata,yydata,'r.-');
xlabel('V(V)');
hold off;
ylabel('J(mA/cm^2)');
