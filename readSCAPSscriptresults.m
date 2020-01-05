function result = readSCAPSscriptresults(pathname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DON'T CHANGE THIS FILE%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% this file reads in the results of the save scriptvariables action in SCAPS
%%% KD, ELIS Ugent 5-5-2011

fip=fopen(pathname,'r');
header = true;


tline=fgetl(fip);
while(ischar(tline))%read everything up to end of file
    if(header == true)
        k=strfind(tline,'mode');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %i');
            result.mode = A(1);
        end;
        k=strfind(tline,'filename');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %s');
            result.filename = A;
        end;
        k=strfind(tline,'loopcounter');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %i');
            result.loopcounter = A(1);
        end;
        k=strfind(tline,'max. nr. of iteration');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %*s %*s %*s %i');
            result.maxiter = A(1);
        end;
        k=strfind(tline,'looperror');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %f');
            result.looperror = A(1);
        end;
        k=strfind(tline,'maxerror');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %f');
            result.maxerror = A(1);
        end;
        k=strfind(tline,'xindex');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %i');
            result.xindex = A(1);
        end;
        k=strfind(tline,'yindex');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %i');
            result.yindex = A(1);
        end;
        k=strfind(tline,'zindex');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %i');
            result.zindex = A(1);
        end;
        k=strfind(tline,'uindex');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %i');
            result.uindex = A(1);
        end;
        k=strfind(tline,'vindex');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %i');
            result.vindex = A(1);
        end;
        k=strfind(tline,'windex');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %i');
            result.windex = A(1);
        end;
        k=strfind(tline,'xvalue');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %f');
            result.xvalue = A(1);
        end;
        k=strfind(tline,'yvalue');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %f');
            result.yvalue = A(1);
        end;
        k=strfind(tline,'zvalue');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %f');
            result.zvalue = A(1);
        end;
        k=strfind(tline,'uvalue');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %f');
            result.uvalue = A(1);
        end;
        k=strfind(tline,'vvalue');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %f');
            result.vvalue = A(1);
        end;
        k=strfind(tline,'wvalue');
        if(~isempty(k) && k(1)>0)
            A=sscanf(tline,'%*s %f');
            result.wvalue = A(1);
        end;
        k=strfind(tline,'dimension');
        if(~isempty(k) && k(1)==1)
            A=sscanf(tline,'%*s %f %f %f %f %f %f');
            result.dimensions = A(1:6);
        end;
        k=strfind(tline,'index');
        if(~isempty(k) && k(1)==1)
            header = false;
        end;
    else %data reading;
        A=sscanf(tline,'%i %f %f %f %f %f %f');
        Alen = length(A);
        if(Alen>0)
            index = A(1)+1;%matlab is 1-based SCAPS is zero-based
        end;
        if(Alen>1)
            for count = 2:Alen;
                result.data(index,count-1) = A(count);                
            end;
        end;
    end;%end if header
       
    tline=fgetl(fip); %read new line
end;

fclose(fip);
