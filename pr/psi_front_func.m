%a parameter to calculate the photon flux spectral density at the boundary
%of front surface
function psi_front=psi_front_func(rr,x,mu,alpha,bn)
%bn should be in m^-3*s^-1
%x should be in m
%alpha is in m^-1
count=0;
for i=1:length(mu)
    if mu(i)<0
        count=count+1;
    end
end
%mu is a symmetric array
%number of negative values is equal to the number of positive values in the
%array
%we use only the positive mu values in the main flow
for i=1:length(alpha)
    x_2(:,i)=x';
end
for i=1:length(x)
    alpha_2(i,:)=alpha;
    rr_3(i,:,:)=rr';
end
for i=(count+1):length(mu)
    bn_3h(:,:,i-count)=bn;
    alpha_3h(:,:,i-count)=alpha_2;
    x_3h(:,:,i-count)=x_2;
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
inter1=bn_3h.*exp(alpha_3h.*(x_3h-2*x(length(x)))./mu_3h);%%%
integ1=trapz(x,inter1,1);
for i=1:length(x)
    integ1_3(i,:,:)=integ1;
end
left=rr_3h.*integ1_3;
inter2=bn_3h.*exp(-1*alpha_3h.*x_3h./mu_3h);
integ2=trapz(x,inter2,1);
for i=1:length(x)
    integ2_3(i,:,:)=integ2;
end
right=integ2_3;%%%
psi_front=left+right;
%now psi_front is three dimensional and only contains mu>0 values