%a parameter to calculate photon recycling generation rate in three dimension
function phi_l=phi_l_func(alpha,mu,rf,rr,x)
%alpha in m^-1
%w should be in m
%for mu values greater than zero
count=0;
for i=1:length(mu)
    if mu(i)<0
        count=count+1;
    end
end
%mu is a symmetric array
%number of negative values is equal to the number of positive values in the
%array
for i=1:length(x)
    alpha_2(i,:)=alpha;
    rf_3(i,:,:)=rf';
    rr_3(i,:,:)=rr';
end
for i=1:count
    alpha_3l(:,:,i)=alpha_2;
    rf_3l(:,:,i)=rf_3(:,:,i);
    rr_3l(:,:,i)=rr_3(:,:,i);
end
for i=1:length(alpha)
    for k=1:length(x)
        for j=1:count
            mu_3l(k,i,j)=mu(j);            
        end
    end
end
% for i=1:length(alpha)
%     for k=1:length(x)
%         mu_3(k,i,:)=mu;
%     end
% end
        
% for i=1:length(mu)
%     alpha_3(:,:,i)=alpha_2;
% end
phi_l=1-(exp(2.*alpha_3l.*x(length(x))./mu_3l).*(rf_3l.*rr_3l));%w is in m
end