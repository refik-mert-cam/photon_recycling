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
%E in ev
%E=[2.55347593582888 2.50352893728574 2.45307251531318 2.401858304,2.351781653,2.301613801,2.251905626,2.201561391,2.151551933,2.101626016,2.051587302,2.001613163,1.951557093,1.901609195,1.851387645,1.801393728,1.751305575,1.701357466,1.651317541,1.60123887,1.551193899,1.501088797];%one of the dimensions
E=[2.351781653,2.301613801,2.251905626,2.201561391,2.151551933,2.101626016,2.051587302,2.001613163,1.951557093,1.901609195,1.851387645,1.801393728,1.751305575,1.701357466,1.651317541,1.60123887,1.551193899,1.501088797];%one of the dimensions
%critical=[0.272992633794140 0.266078846705128 0.256747493683866 0.240113 0.243359 0.246688 0.24918 0.251844 0.254304 0.256614 0.258763 0.260812 0.262683 0.264441 0.265936 0.267375 0.268904 0.270524 0.272165 0.273674 0.274893 0.276278]; 
critical=[0.243359 0.246688 0.24918 0.251844 0.254304 0.256614 0.258763 0.260812 0.262683 0.264441 0.265936 0.267375 0.268904 0.270524 0.272165 0.273674 0.274893 0.276278];
%E=[6.00919651500484 5.95729366602687 5.90909090909091 5.85889570552147 5.80682881197381 5.75834879406308 5.70804597701149 5.65861440291705 5.60749774164408 5.55729632945389 5.50798580301686 5.45714285714286 5.40722996515679 5.35822183858438 5.30782385634887 5.25613886536833 5.20763422818792 5.15787287079352 5.10695187165775 5.05702647657841 5.00604838709677 4.95608782435130 4.90711462450593 4.85719874804382 4.80642663569493 4.75670498084291 4.70621683093252 4.65678919729932 4.60667903525046 4.55596330275229 4.50635208711434 4.45620961952620 4.40560681334280 4.35614035087719 4.30627818244884 4.25608501885499 4.20562330623306 4.15495314591700 4.10548941798942 4.05586409670042 4.00483870967742 3.95508123606244 3.90531613715005 3.85559006211180 3.80478087649402 3.75529340592861 3.70486421963593 3.65469531939947 3.60481997677120 3.55425135986258 3.50508187464709 3.45436839176405 3.40416780915821 3.35449878411240 3.30449826989619 3.25425950196592 3.20387096774194 3.15421747967480 3.10452613153288 3.05412054120541 3.00387127994193 2.95384249345705 2.90409356725146 2.85402298850575 2.80374887082204 2.75338212463961 2.70361498257840 2.65334473178030 2.60327112602223 2.55347593582888 2.50352893728574 2.45307251531318 2.40321331784746 2.35310841546626 2.30291226117603 2.25317604355717 2.20280340667140 2.15276573608462 2.10281165311653 2.05274470899471 2.00274237780287 1.95265806857502 1.90268199233716 1.85243210981796 1.80240998838560 1.75229357798165 1.70231729055258 1.65224913494810 1.60214221189831 1.55206900862608 1.50193563997097 1.45187697345340 1.40187443541102 1.35180749128920 1.30177204571668 1.25163826998689 1.20183930300097 1.15166975881262 1.10159716060337 1.05122777307367 1.00120967741935 0.951340996168582 0.900943396226415 0.850925291295408 0.800967741935484 0.751058681185723 0.701016374929418 0.651022548505506 0.600919651500484 0.550798580301686 0.500604838709677];
%critical=[0.912669371778471 0.903577908198674 0.888929497933170 0.877636419218143 0.867595906588762 0.861354112297048 0.855222614409270 0.845801713411929 0.834990066174775 0.822135041233276 0.808230247207772 0.792699499983475 0.774418749100258 0.753866450593115 0.730324498151338 0.706176302692792 0.675632346790661 0.638887726007646 0.588289585400222 0.520158743969718 0.455539883824155 0.397534980964133 0.353326535607132 0.324223452532345 0.303877216717627 0.290777577757553 0.281640809299283 0.274358294406229 0.268538256800706 0.263103006097851 0.258425233397854 0.254108466568497 0.251715746610980 0.253262556530857 0.256680842359823 0.260880532858806 0.265578148990386 0.270006599143842 0.274282061217943 0.278068690947722 0.281399774949984 0.284238146202547 0.286551015344816 0.288310889914105 0.289666543306198 0.290606086567248 0.291035200148468 0.290863400426864 0.290178255606592 0.288902400322379 0.287135212817493 0.284812805256809 0.281801731650037 0.278147073065682 0.272992633794140 0.266078846705128 0.256747493683866 0.242702549892727 0.230717392886178 0.227487013228235 0.223638183427963 0.210092711347504 0.199257329301303 0.199097571621499 0.203045869160437 0.208416391910679 0.214683209489473 0.219821016297308 0.224499025878212 0.228852666939317 0.232886423610623 0.236613287257405 0.240112734707153 0.243358847358756 0.246387791409308 0.249179748798704 0.251843917343915 0.254304488826280 0.256614226034029 0.258763447137945 0.260811692694825 0.262683377405253 0.264440830127517 0.265935595258603 0.267375176868234 0.268903823902282 0.270524369211270 0.272164823883905 0.273673737718481 0.274893131552550 0.276278181122951 0.278068690947722 0.280360109207980 0.283421273393924 0.286467755412044 0.288648594490142 0.290434800595829 0.292156940326947 0.293637147759596 0.295132666350814 0.296465150225193 0.297719877120926 0.298803977693543 0.299896130652110 0.300904422831836 0.301827050565636 0.302755447434820 0.303502355782278 0.304253020291084 0.304912955670139 0.305575808525278];
rf=rf_func(critical);%two dimensional E and mu
rr=zeros(10,18);
angle=linspace(pi,2*pi,10);
mu=cos(angle);%one of the dimensions
%alpha=[1140000 1060000 985000 90250, 81900, 74590, 67750, 61540, 56010, 51080, 46800, 42770, 38530, 34470, 31020, 27550, 23250, 19300, 16680, 14760, 13990, 12160];
alpha=[81900, 74590, 67750, 61540, 56010, 51080, 46800, 42770, 38530, 34470, 31020, 27550, 23250, 19300, 16680, 14760, 13990, 12160];
%alpha=[1500000 1520000 1530000 1540000 1540000 1550000 1570000 1580000 1600000 1620000 1640000 1660000 1690000 1720000 1750000 1790000 1840000 1900000 1960000 2030000 2070000 2060000 2010000 1930000 1830000 1740000 1640000 1560000 1480000 1410000 1330000 1240000 1140000 1060000 985000 927000 881000 845000 818000 796000 778000 764000 753000 743000 735000 729000 724000 720000 717000 715000 714000 714000 715000 718000 723000 738000 742000 714000 674000 634000 592000 558000 506000 393000 281000 225000 191000 163000 142000 125000 112000 100000 90250 81900 74590 67750 61540 56010 51080 46800 42770 38530 34470 31020 27550 23250 19300 16680 14760 13990 12160 5917 239.800000000000 554 0 13.4300000000000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
%n=[4.40800000000000 4.33300000000000 4.26600000000000 4.205 4.15 4.1 4.055 4.013 3.975 3.94 3.908 3.878 3.851 3.826 3.805 3.785 3.764 3.742 3.72 3.7 3.684 3.666];%refractive index of the material
n=[4.15 4.1 4.055 4.013 3.975 3.94 3.908 3.878 3.851 3.826 3.805 3.785 3.764 3.742 3.72 3.7 3.684 3.666];%refractive index of the material
%n=[1.26400000000000 1.27300000000000 1.28800000000000 1.30000000000000 1.31100000000000 1.31800000000000 1.32500000000000 1.33600000000000 1.34900000000000 1.36500000000000 1.38300000000000 1.40400000000000 1.43000000000000 1.46100000000000 1.49900000000000 1.54100000000000 1.59900000000000 1.67700000000000 1.80200000000000 2.01200000000000 2.27300000000000 2.58300000000000 2.89000000000000 3.13900000000000 3.34200000000000 3.48800000000000 3.59800000000000 3.69100000000000 3.76900000000000 3.84500000000000 3.91300000000000 3.97800000000000 4.01500000000000 3.99100000000000 3.93900000000000 3.87700000000000 3.81000000000000 3.74900000000000 3.69200000000000 3.64300000000000 3.60100000000000 3.56600000000000 3.53800000000000 3.51700000000000 3.50100000000000 3.49000000000000 3.48500000000000 3.48700000000000 3.49500000000000 3.51000000000000 3.53100000000000 3.55900000000000 3.59600000000000 3.64200000000000 3.70900000000000 3.80300000000000 3.93800000000000 4.16100000000000 4.37300000000000 4.43400000000000 4.50900000000000 4.79500000000000 5.05200000000000 5.05600000000000 4.95900000000000 4.83300000000000 4.69400000000000 4.58600000000000 4.49200000000000 4.40800000000000 4.33300000000000 4.26600000000000 4.20500000000000 4.15000000000000 4.10000000000000 4.05500000000000 4.01300000000000 3.97500000000000 3.94000000000000 3.90800000000000 3.87800000000000 3.85100000000000 3.82600000000000 3.80500000000000 3.78500000000000 3.76400000000000 3.74200000000000 3.72000000000000 3.70000000000000 3.68400000000000 3.66600000000000 3.64300000000000 3.61400000000000 3.57600000000000 3.53900000000000 3.51300000000000 3.49200000000000 3.47200000000000 3.45500000000000 3.43800000000000 3.42300000000000 3.40900000000000 3.39700000000000 3.38500000000000 3.37400000000000 3.36400000000000 3.35400000000000 3.34600000000000 3.33800000000000 3.33100000000000 3.32400000000000];
alpha=alpha*100;%alpha is im m^-1
T=[300];%temperature of the environment in K
x=xdata;
x=x*10^-6; %it should be in m

low_phi=ydata-yydata; %local potential difference values


bn=bn_func(n,E,low_phi,T,x,alpha);
phi=phi_func(alpha,mu,rf,rr,x);
psi_rear=psi_rear_func(rf,x,mu,alpha,bn);
psi_front=psi_front_func(rr,x,mu,alpha,bn);
b=b_func(alpha,mu,x,rf,rr,phi,bn,psi_rear,psi_front);
Eg=[2.092];%bandgap of the semiconductor
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
% %in cm^3
% gpr_end=gpr_end*1e6;

generation_file1=[x'/10^-6; gpr_end'];

%set filenames
scriptfile = 'pr_cell.gen';
%write script
scriptpath = [SCAPSfolder '\generation\' scriptfile];
writeSCAPSscript_generation_file(scriptpath,generation_file1);

%set filenames
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
jdataprime=jdata_old(1);

for a=1:2
% while abs(jdata(1)-jdata_old(1))>1e-8 
% %     || abs(jdata(1))>abs(jdataprime)
%   
    
    jdata_old=jdata;
    E=[2.351781653,2.301613801,2.251905626,2.201561391,2.151551933,2.101626016,2.051587302,2.001613163,1.951557093,1.901609195,1.851387645,1.801393728,1.751305575,1.701357466,1.651317541,1.60123887,1.551193899,1.501088797];%one of the dimensions
    %E=[2.401858304,2.351781653,2.301613801,2.251905626,2.201561391,2.151551933,2.101626016,2.051587302,2.001613163,1.951557093,1.901609195,1.851387645,1.801393728,1.751305575,1.701357466,1.651317541,1.60123887,1.551193899,1.501088797];%one of the dimensions
    %E=[6.00919651500484 5.95729366602687 5.90909090909091 5.85889570552147 5.80682881197381 5.75834879406308 5.70804597701149 5.65861440291705 5.60749774164408 5.55729632945389 5.50798580301686 5.45714285714286 5.40722996515679 5.35822183858438 5.30782385634887 5.25613886536833 5.20763422818792 5.15787287079352 5.10695187165775 5.05702647657841 5.00604838709677 4.95608782435130 4.90711462450593 4.85719874804382 4.80642663569493 4.75670498084291 4.70621683093252 4.65678919729932 4.60667903525046 4.55596330275229 4.50635208711434 4.45620961952620 4.40560681334280 4.35614035087719 4.30627818244884 4.25608501885499 4.20562330623306 4.15495314591700 4.10548941798942 4.05586409670042 4.00483870967742 3.95508123606244 3.90531613715005 3.85559006211180 3.80478087649402 3.75529340592861 3.70486421963593 3.65469531939947 3.60481997677120 3.55425135986258 3.50508187464709 3.45436839176405 3.40416780915821 3.35449878411240 3.30449826989619 3.25425950196592 3.20387096774194 3.15421747967480 3.10452613153288 3.05412054120541 3.00387127994193 2.95384249345705 2.90409356725146 2.85402298850575 2.80374887082204 2.75338212463961 2.70361498257840 2.65334473178030 2.60327112602223 2.55347593582888 2.50352893728574 2.45307251531318 2.40321331784746 2.35310841546626 2.30291226117603 2.25317604355717 2.20280340667140 2.15276573608462 2.10281165311653 2.05274470899471 2.00274237780287 1.95265806857502 1.90268199233716 1.85243210981796 1.80240998838560 1.75229357798165 1.70231729055258 1.65224913494810 1.60214221189831 1.55206900862608 1.50193563997097 1.45187697345340 1.40187443541102 1.35180749128920 1.30177204571668 1.25163826998689 1.20183930300097 1.15166975881262 1.10159716060337 1.05122777307367 1.00120967741935 0.951340996168582 0.900943396226415 0.850925291295408 0.800967741935484 0.751058681185723 0.701016374929418 0.651022548505506 0.600919651500484 0.550798580301686 0.500604838709677];
    %critical=[0.912669371778471 0.903577908198674 0.888929497933170 0.877636419218143 0.867595906588762 0.861354112297048 0.855222614409270 0.845801713411929 0.834990066174775 0.822135041233276 0.808230247207772 0.792699499983475 0.774418749100258 0.753866450593115 0.730324498151338 0.706176302692792 0.675632346790661 0.638887726007646 0.588289585400222 0.520158743969718 0.455539883824155 0.397534980964133 0.353326535607132 0.324223452532345 0.303877216717627 0.290777577757553 0.281640809299283 0.274358294406229 0.268538256800706 0.263103006097851 0.258425233397854 0.254108466568497 0.251715746610980 0.253262556530857 0.256680842359823 0.260880532858806 0.265578148990386 0.270006599143842 0.274282061217943 0.278068690947722 0.281399774949984 0.284238146202547 0.286551015344816 0.288310889914105 0.289666543306198 0.290606086567248 0.291035200148468 0.290863400426864 0.290178255606592 0.288902400322379 0.287135212817493 0.284812805256809 0.281801731650037 0.278147073065682 0.272992633794140 0.266078846705128 0.256747493683866 0.242702549892727 0.230717392886178 0.227487013228235 0.223638183427963 0.210092711347504 0.199257329301303 0.199097571621499 0.203045869160437 0.208416391910679 0.214683209489473 0.219821016297308 0.224499025878212 0.228852666939317 0.232886423610623 0.236613287257405 0.240112734707153 0.243358847358756 0.246387791409308 0.249179748798704 0.251843917343915 0.254304488826280 0.256614226034029 0.258763447137945 0.260811692694825 0.262683377405253 0.264440830127517 0.265935595258603 0.267375176868234 0.268903823902282 0.270524369211270 0.272164823883905 0.273673737718481 0.274893131552550 0.276278181122951 0.278068690947722 0.280360109207980 0.283421273393924 0.286467755412044 0.288648594490142 0.290434800595829 0.292156940326947 0.293637147759596 0.295132666350814 0.296465150225193 0.297719877120926 0.298803977693543 0.299896130652110 0.300904422831836 0.301827050565636 0.302755447434820 0.303502355782278 0.304253020291084 0.304912955670139 0.305575808525278];
    critical=[0.243359 0.246688 0.24918 0.251844 0.254304 0.256614 0.258763 0.260812 0.262683 0.264441 0.265936 0.267375 0.268904 0.270524 0.272165 0.273674 0.274893 0.276278];
    %critical=[0.240113 0.243359 0.246688 0.24918 0.251844 0.254304 0.256614 0.258763 0.260812 0.262683 0.264441 0.265936 0.267375 0.268904 0.270524 0.272165 0.273674 0.274893 0.276278]; 
    rf=rf_func(critical);%two dimensional E and mu
    rr=zeros(10,18);
    angle=linspace(pi,2*pi,10);
    mu=cos(angle);%one of the dimensions
    %alpha=[1500000 1520000 1530000 1540000 1540000 1550000 1570000 1580000 1600000 1620000 1640000 1660000 1690000 1720000 1750000 1790000 1840000 1900000 1960000 2030000 2070000 2060000 2010000 1930000 1830000 1740000 1640000 1560000 1480000 1410000 1330000 1240000 1140000 1060000 985000 927000 881000 845000 818000 796000 778000 764000 753000 743000 735000 729000 724000 720000 717000 715000 714000 714000 715000 718000 723000 738000 742000 714000 674000 634000 592000 558000 506000 393000 281000 225000 191000 163000 142000 125000 112000 100000 90250 81900 74590 67750 61540 56010 51080 46800 42770 38530 34470 31020 27550 23250 19300 16680 14760 13990 12160 5917 239.800000000000 554 0 13.4300000000000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    alpha=[81900, 74590, 67750, 61540, 56010, 51080, 46800, 42770, 38530, 34470, 31020, 27550, 23250, 19300, 16680, 14760, 13990, 12160];
    %alpha=[90250, 81900, 74590, 67750, 61540, 56010, 51080, 46800, 42770, 38530, 34470, 31020, 27550, 23250, 19300, 16680, 14760, 13990, 12160];
    %n=[1.26400000000000 1.27300000000000 1.28800000000000 1.30000000000000 1.31100000000000 1.31800000000000 1.32500000000000 1.33600000000000 1.34900000000000 1.36500000000000 1.38300000000000 1.40400000000000 1.43000000000000 1.46100000000000 1.49900000000000 1.54100000000000 1.59900000000000 1.67700000000000 1.80200000000000 2.01200000000000 2.27300000000000 2.58300000000000 2.89000000000000 3.13900000000000 3.34200000000000 3.48800000000000 3.59800000000000 3.69100000000000 3.76900000000000 3.84500000000000 3.91300000000000 3.97800000000000 4.01500000000000 3.99100000000000 3.93900000000000 3.87700000000000 3.81000000000000 3.74900000000000 3.69200000000000 3.64300000000000 3.60100000000000 3.56600000000000 3.53800000000000 3.51700000000000 3.50100000000000 3.49000000000000 3.48500000000000 3.48700000000000 3.49500000000000 3.51000000000000 3.53100000000000 3.55900000000000 3.59600000000000 3.64200000000000 3.70900000000000 3.80300000000000 3.93800000000000 4.16100000000000 4.37300000000000 4.43400000000000 4.50900000000000 4.79500000000000 5.05200000000000 5.05600000000000 4.95900000000000 4.83300000000000 4.69400000000000 4.58600000000000 4.49200000000000 4.40800000000000 4.33300000000000 4.26600000000000 4.20500000000000 4.15000000000000 4.10000000000000 4.05500000000000 4.01300000000000 3.97500000000000 3.94000000000000 3.90800000000000 3.87800000000000 3.85100000000000 3.82600000000000 3.80500000000000 3.78500000000000 3.76400000000000 3.74200000000000 3.72000000000000 3.70000000000000 3.68400000000000 3.66600000000000 3.64300000000000 3.61400000000000 3.57600000000000 3.53900000000000 3.51300000000000 3.49200000000000 3.47200000000000 3.45500000000000 3.43800000000000 3.42300000000000 3.40900000000000 3.39700000000000 3.38500000000000 3.37400000000000 3.36400000000000 3.35400000000000 3.34600000000000 3.33800000000000 3.33100000000000 3.32400000000000];
    alpha=alpha*100;%alpha is im m^-1
    %n=[4.205 4.15 4.1 4.055 4.013 3.975 3.94 3.908 3.878 3.851 3.826 3.805 3.785 3.764 3.742 3.72 3.7 3.684 3.666];%refractive index of the material
    n=[4.15 4.1 4.055 4.013 3.975 3.94 3.908 3.878 3.851 3.826 3.805 3.785 3.764 3.742 3.72 3.7 3.684 3.666];%refractive index of the material
    T=[300];%temperature of the environment in K
    x=x_new;
    x=x*10^-6;

    low_phi=efn_new-efp_new; %local potential difference values
    
    
    bn=bn_func(n,E,low_phi,T,x,alpha);
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
    %in cm^3
%     gpr_end=gpr_end*1e6;

    generation_file1=[x'/10^-6; gpr_end'];

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
    
    
end
