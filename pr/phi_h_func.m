%a parameter to calculate photon recycling generation rate in three dimension
function phi_h=phi_h_func(alpha,mu,rf,rr,x)
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
for i=(count+1):length(mu)
    alpha_3h(:,:,i-count)=alpha_2;
    rf_3h(:,:,i-count)=rf_3(:,:,i);
    rr_3h(:,:,i-count)=rr_3(:,:,i);
end
for i=1:length(alpha)
    for k=1:length(x)
        for j=(count+1):length(mu)
            mu_3h(k,i,j-count)=mu(j);            
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
phi_h=1-(exp(-2.*alpha_3h.*x(length(x))./mu_3h).*(rf_3h.*rr_3h));%w is in m
end