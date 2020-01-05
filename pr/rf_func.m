function rf=rf_func(critical)
angle=linspace(0,pi,10);
rf=[];
for k=1:length(critical)
    for i=1:10
        if critical(k)>=angle(i)
            rf(i,k)=1;
        else
            rf(i,k)=0;
        end
    end
end 
end