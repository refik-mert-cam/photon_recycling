function writeSCAPSscript_generation_file(pathin,generation_file)

fip=fopen(pathin,'w');

%comments
fprintf(fip,'//Generation profile\n');

%load files and set quit policy

fprintf(fip,'%f  %f\n',generation_file);


fclose(fip);
