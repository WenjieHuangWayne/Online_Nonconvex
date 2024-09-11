function [L]=oracle(x,n,exponent,data)
D=2430;A=60;v=80;% Parameters
s=x(1); l=x(2); t=x(3);
%Consideration of zzz
L=0;i=1;
while i<=n-1
    L=L+((s/(A*sqrt(4*pi*D*(data(i,1)-t))))*exp(-((data(i,2)-l-v*(data(i,1)-t))^2)/(4*D*(data(i,1)-t)))-data(i,3))^2;
    i=i+1;
end
L=L-exponent(1)*x(1)-exponent(2)*x(2)-exponent(3)*x(3);