%a parameter to calculate the photon flux spectral density at the boundary
%of rear surface
function psi_rear=psi_rear_func(rf,x,mu,alpha,bn)
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
%we use only the negative mu values in the main flow
for i=1:length(alpha)
    x_2(:,i)=x';
end
for i=1:length(x)
    alpha_2(i,:)=alpha;
    rf_3(i,:,:)=rf';
end
for i=1:count
    bn_3l(:,:,i)=bn;
    alpha_3l(:,:,i)=alpha_2;
    x_3l(:,:,i)=x_2;
    rf_3l(:,:,i)=rf_3(:,:,i);
end
for i=1:length(alpha)
    for k=1:length(x)
        for j=1:count
            mu_3l(k,i,j)=mu(j);            
        end
    end
end
% for i=1:length(mu)
%     bn_3(:,:,i)=bn;
%     alpha_3(:,:,i)=alpha_2;
%     x_3(:,:,i)=x_2;
% end
% for i=1:length(alpha)
%     for k=1:length(x)
%         mu_3(k,i,:)=mu;
%     end
% end
inter1=bn_3l.*exp(alpha_3l.*(x_3l+x(length(x)))./mu_3l);
integ1=trapz(x,inter1,1);
for i=1:length(x)
    integ1_3(i,:,:)=integ1;
end
left=rf_3l.*integ1_3;
inter2=bn_3l.*exp(-1*alpha_3l.*(x_3l-x(length(x)))./mu_3l);
integ2=trapz(x,inter2,1);
for i=1:length(x)
    integ2_3(i,:,:)=integ2;
end
right=integ2_3;
psi_rear=left+right;
% psi_rear=-1*psi_rear;
%now psi_rear is three dimensional