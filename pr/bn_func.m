%photon flux spectral density for spontaneously emitted photons at each
%point x bn
%in general equations we have 3 dimensions which are E, x, and mu
%in this function since bn changes in two dimensions which are E and x, i
%have built two dimensional arrays 
%E first dimension
%x second dmension
%mu third dimension
function bn=bn_func(n,E,low_phi,T,x,alpha)
%n:refractive index of the active substrate
%E:energy
%low_phi:local potential difference
%T:temperature in kelvin
%x:depth of the interested point in the solar cell
bn=[];
h=4.13566766225*10^-15; %eV*s
c=299792458; %m/s
%q=1.60217662*10^-19;
q=1;
k=8.6173303*10^-5;%ev/K
for i=1:length(x)
    E_2(i,:)=E;
    n_2(i,:)=n;
    alpha_2(i,:)=alpha;
end
for i=1:length(E)
    low_phi_2(:,i)=low_phi';
    x_2(:,i)=x';
end
%bn=8*pi*(E_2).*(E_2).*alpha_2./(c^2*h^2*(exp((E_2-q*low_phi_2)/(k*T))-1));
%bn=(2*4*pi*pi.*alpha_2.*n_2.*n_2.*E_2.*E_2)./(h^2*c^2*(exp((E_2-q*low_phi_2)/(k*T))-1));
bn=2*n_2.*n_2.*E_2.*E_2./(c^2)./(h^3)./(exp((E_2-q*low_phi_2)/(k*T))-1);
end