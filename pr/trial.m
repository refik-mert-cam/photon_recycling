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
SCAPSfolder = 'C:\Users\user\Desktop\pr_new\Scaps3307';%your local SCAPS folder !!!MAKE SURE THERE ARE NO SPACES IN YOUR SCAPS PATH, THIS IS A MATLAB ISSUE :-(
SCAPSversion = 'scaps3307.exe'; %your SCAPS version !!!also avoid spaces here

%set filenamess
scriptfile = 'pr_cell_dark_1.script';
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

%set filenamess
scriptfile = 'pr_cell_dark_2.script';
outputfile = 'scriptMatlabResults2.xls';

%write script
scriptpath = [SCAPSfolder '\script\' scriptfile];
writeSCAPSscript2(scriptpath,outputfile);

%execute SCAPS
orderToSCAPS = ['! ' SCAPSfolder '\' SCAPSversion ' ' scriptfile];
eval(orderToSCAPS);

%read in results
pathname = [SCAPSfolder '\results\' outputfile];
result = readSCAPSscriptresults(pathname);

yydata = result.data(1:result.dimensions(2),2);%yy
vdata_old = result.data(1:result.dimensions(3),3);%previous voltage value
jdata_old = result.data(1:result.dimensions(4),4);%previous current density value

%%main flow is added here

%main flow of the numerical modelling of photon recycling
%GaAs
%input 
E=[2.401858304,2.351781653,2.301613801,2.251905626,2.201561391,2.151551933,2.101626016,2.051587302,2.001613163,1.951557093,1.901609195,1.851387645,1.801393728,1.751305575,1.701357466,1.651317541,1.60123887,1.551193899,1.501088797];%one of the dimensions
critical=[0.240113 0.243359 0.246688 0.24918 0.251844 0.254304 0.256614 0.258763 0.260812 0.262683 0.264441 0.265936 0.267375 0.268904 0.270524 0.272165 0.273674 0.274893 0.276278]; 
rf=rf_func(critical);%two dimensional E and mu
rr=zeros(10,19);
angle=linspace(pi,2*pi,10);
mu=cos(angle);%one of the dimensions
alpha=[90250, 81900, 74590, 67750, 61540, 56010, 51080, 46800, 42770, 38530, 34470, 31020, 27550, 23250, 19300, 16680, 14760, 13990, 12160];
n=[4.205 4.15 4.1 4.055 4.013 3.975 3.94 3.908 3.878 3.851 3.826 3.805 3.785 3.764 3.742 3.72 3.7 3.684 3.666];%refractive index of the material
T=[300];%temperature of the environment in K
x=xdata;
x=x*10^-4;

low_phi=ydata-yydata; %local potential difference values

bn=bn_func(n,E,low_phi,T,x);
phi=phi_func(alpha,mu,rf,rr,x);
psi_rear=psi_rear_func(rf,x,mu,alpha,bn);
psi_front=psi_front_func(rr,x,mu,alpha,bn);
b=b_func(alpha,mu,x,rf,rr,phi,bn,psi_rear,psi_front);
Eg=[1.424];%bandgap of the semiconductor
count=0;
for i=1:length(E)
    if E(i)>=Eg
        count=count+1;
    end
end
E_great=[];
alpha_2=[];
alpha_3=[];
b_great=[];
alpha_3_great=[];
for z=1:count
    E_great(z)=E(z);
end
for i=1:length(x)
    alpha_2(i,:)=alpha;
end
for i=1:length(mu)
    alpha_3(:,:,i)=alpha_2;
end
for m=1:count
    b_great(:,m,:)=b(:,m,:);
    alpha_3_great(:,m,:)=alpha_3(:,m,:);
end
gpr_1=trapz(mu,b_great.*alpha_3_great,3);
gpr_2=trapz(E_great,gpr_1,2);
gpr_end=-2*pi*gpr_2;

generation_file1=[x'/10^-4; gpr_end'];

%set filenamess
scriptfile = 'pr_cell.gen';
%write script
scriptpath = [SCAPSfolder '\generation\' scriptfile];
writeSCAPSscript_generation_file(scriptpath,generation_file1);

%set filenamess
scriptfile = 'pr_cell_withgeneration.script';
outputfile = 'scriptMatlabResults3.xls';

%write script
scriptpath = [SCAPSfolder '\script\' scriptfile];
writeSCAPSscript_withgeneration1(scriptpath,outputfile);

%execute SCAPS
orderToSCAPS = ['! ' SCAPSfolder '\' SCAPSversion ' ' scriptfile];
eval(orderToSCAPS);

%read in results
pathname = [SCAPSfolder '\results\' outputfile];
result = readSCAPSscriptresults(pathname);

x_new = result.data(1:result.dimensions(1),1);%depth
efp_new = result.data(1:result.dimensions(2),2);%efp
vdata = result.data(1:result.dimensions(3),3);%voltage
jdata = result.data(1:result.dimensions(4),4);%current density

%set filenamess
scriptfile = 'pr_cell_withgeneration_2.script';
outputfile = 'scriptMatlabResults4.xls';

%write script
scriptpath = [SCAPSfolder '\script\' scriptfile];
writeSCAPSscript_withgeneration2(scriptpath,outputfile);

%execute SCAPS
orderToSCAPS = ['! ' SCAPSfolder '\' SCAPSversion ' ' scriptfile];
eval(orderToSCAPS);

%read in results
pathname = [SCAPSfolder '\results\' outputfile];
result = readSCAPSscriptresults(pathname);

efn_new = result.data(1:result.dimensions(2),2);%new efn



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    jdata_old=jdata;
    E=[2.401858304,2.351781653,2.301613801,2.251905626,2.201561391,2.151551933,2.101626016,2.051587302,2.001613163,1.951557093,1.901609195,1.851387645,1.801393728,1.751305575,1.701357466,1.651317541,1.60123887,1.551193899,1.501088797];%one of the dimensions
    critical=[0.240113 0.243359 0.246688 0.24918 0.251844 0.254304 0.256614 0.258763 0.260812 0.262683 0.264441 0.265936 0.267375 0.268904 0.270524 0.272165 0.273674 0.274893 0.276278]; 
    rf=rf_func(critical);%two dimensional E and mu
    rr=zeros(10,19);
    angle=linspace(pi,2*pi,10);
    mu=cos(angle);%one of the dimensions
    alpha=[90250, 81900, 74590, 67750, 61540, 56010, 51080, 46800, 42770, 38530, 34470, 31020, 27550, 23250, 19300, 16680, 14760, 13990, 12160];
    n=[4.205 4.15 4.1 4.055 4.013 3.975 3.94 3.908 3.878 3.851 3.826 3.805 3.785 3.764 3.742 3.72 3.7 3.684 3.666];%refractive index of the material
    T=[300];%temperature of the environment in K
    x=x_new;
    x=x*10^-4;

    low_phi=efn_new-efp_new; %local potential difference values

    bn=bn_func(n,E,low_phi,T,x);
    phi=phi_func(alpha,mu,rf,rr,x);
    psi_rear=psi_rear_func(rf,x,mu,alpha,bn);
    psi_front=psi_front_func(rr,x,mu,alpha,bn);
    b=b_func(alpha,mu,x,rf,rr,phi,bn,psi_rear,psi_front);
    Eg=[1.424];%bandgap of the semiconductor
    count=0;
    for i=1:length(E)
        if E(i)>=Eg
            count=count+1;
        end
    end
    E_great=[];
    alpha_2=[];
    alpha_3=[];
    b_great=[];
    alpha_3_great=[];
    for z=1:count
        E_great(z)=E(z);
    end
    for i=1:length(x)
        alpha_2(i,:)=alpha;
    end
    for i=1:length(mu)
        alpha_3(:,:,i)=alpha_2;
    end
    for m=1:count
        b_great(:,m,:)=b(:,m,:);
        alpha_3_great(:,m,:)=alpha_3(:,m,:);
    end
    gpr_1=trapz(mu,b_great.*alpha_3_great,3);
    gpr_2=trapz(E_great,gpr_1,2);
    gpr_end=-2*pi*gpr_2;

    generation_file1=[x'/10^-4; gpr_end'];

%     %set filenamess
%     scriptfile = 'pr_cell.gen';
%     %write script
%     scriptpath = [SCAPSfolder '\generation\' scriptfile];
%     writeSCAPSscript_generation_file(scriptpath,generation_file1);
% 
%     %set filenamess
%     scriptfile = 'pr_cell_withgeneration.script';
%     outputfile = 'scriptMatlabResults3.xls';
% 
%     %write script
%     scriptpath = [SCAPSfolder '\script\' scriptfile];
%     writeSCAPSscript_withgeneration1(scriptpath,outputfile);
% 
%     %execute SCAPS
%     orderToSCAPS = ['! ' SCAPSfolder '\' SCAPSversion ' ' scriptfile];
%     eval(orderToSCAPS);
% 
%     %read in results
%     pathname = [SCAPSfolder '\results\' outputfile];
%     result = readSCAPSscriptresults(pathname);
% 
%     x_new = result.data(1:result.dimensions(1),1);%depth
%     efp_new = result.data(1:result.dimensions(2),2);%efp
%     vdata = result.data(1:result.dimensions(3),3);%voltage
%     jdata = result.data(1:result.dimensions(4),4);%current density
% 
%     %set filenamess
%     scriptfile = 'pr_cell_withgeneration_2.script';
%     outputfile = 'scriptMatlabResults4.xls';
% 
%     %write script
%     scriptpath = [SCAPSfolder '\script\' scriptfile];
%     writeSCAPSscript_withgeneration2(scriptpath,outputfile);
% 
%     %execute SCAPS
%     orderToSCAPS = ['! ' SCAPSfolder '\' SCAPSversion ' ' scriptfile];
%     eval(orderToSCAPS);
% 
%     %read in results
%     pathname = [SCAPSfolder '\results\' outputfile];
%     result = readSCAPSscriptresults(pathname);
% 
%     efn_new = result.data(1:result.dimensions(2),2);%new efn
