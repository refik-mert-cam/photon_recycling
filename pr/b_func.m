%photon flux spectral density
function b=b_func(alpha,mu,x,rf,rr,phi_h,phi_l,bn,psi_rear,psi_front)
%code counting the elements of mu which are less than zero
count=0;
for i=1:length(mu)
    if mu(i)<0
        count=count+1;
    end
end
%for mu values less than zero
for i=1:length(x)
    alpha_2(i,:)=alpha;
    rf_3(i,:,:)=rf';
    rr_3(i,:,:)=rr';
end
for i=1:length(alpha)
    x_2(:,i)=x';
end
 
for i=1:count
    bn_3l(:,:,i)=bn;
    alpha_3l(:,:,i)=alpha_2;
    x_3l(:,:,i)=x_2;
end
%constructing three dimensional mu vector for values less than zero
for i=1:length(alpha)
    for k=1:length(x)
        for j=1:count
            mu_3l(k,i,j)=mu(j);
        end
    end
end
multiplier_l=-1*alpha_3l./mu_3l.*exp(-1*alpha_3l.*(x_3l-x(length(x)))./mu_3l);
%constructing three dimensional arrays for mu less than zero
for i=1:count
%     phi_3l(:,:,i)=phi(:,:,i);
    rr_3l(:,:,i)=rr_3(:,:,i);
%     psi_rear_3l(:,:,i)=psi_rear(:,:,i);
end
right_1_l=rr_3l./phi_l.*psi_rear;
right_1pre_l=right_1_l.*multiplier_l;
integration_domain_l=[];
integration_volume_l=[];
% inter1_l=bn_3l.*exp(alpha_3l.*x_3l./mu_3l);

for m=length(x):-1:1
	integration_domain_l=cat(1,integration_domain_l,[x(m)]);
	inter1_l=bn_3l.*exp(alpha_3l.*(x_3l-integration_domain_l(length(x)-m+1,1,1))./mu_3l);
	integration_volume_l=cat(1,integration_volume_l,inter1_l(m,:,:));                      right_2pre_l(m,:,:)=trapz(integration_domain_l,integration_volume_l,1);
end  



right_2pre_l=alpha_3l./mu_3l.*right_2pre_l;
b_less=right_1pre_l+right_2pre_l;
%for mu less than zero b is equal to;
% b_less=multiplier.*(right_1_l+right_2pre_l);
%for mu greater than zero
for i=1:length(alpha)
    for k=1:length(x)
        for j=(count+1):length(mu)
            mu_3h(k,i,j-count)=mu(j);
        end
    end
end
for i=(count+1):length(mu)
    alpha_3h(:,:,i-count)=alpha_2;
    x_3h(:,:,i-count)=x_2;
%     phi_3h(:,:,i-count)=phi(:,:,i);
    rf_3h(:,:,i-count)=rf_3(:,:,i);
%     psi_front_3h(:,:,i-count)=psi_front(:,:,i);
    bn_3h(:,:,i-count)=bn(:,:);
end
multiplier_h=alpha_3h./mu_3h.*exp(-1*alpha_3h.*x_3h./mu_3h);
right_h1=rf_3h.*psi_front./phi_h;
integration_domain_h=[];
integration_volume_h=[];
% inter1_h=bn_3h.*exp(alpha_3h.*x_3h./mu_3h);
for m=1:length(x)
    integration_domain_h=cat(1,integration_domain_h,[x(m)]);
    inter1_h=bn_3h.*exp(alpha_3h.*(x_3h-integration_domain_l(length(x)-m+1,1,1))./mu_3h);
    integration_volume_h=cat(1,integration_volume_h,inter1_h(m,:,:));
    right_2pre_h(m,:,:)=trapz(integration_domain_h,integration_volume_h,1);
end 


 
%for mu greater than zero b is equal to
% b_high=multiplier_h.*(right_h1+right_2pre_h);
b_high=multiplier_h.*right_h1+right_2pre_h.*alpha_3h./mu_3h;
b=cat(3,b_less,b_high);
end
    
    

    