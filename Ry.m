function [y1]=Ry(x,n,b,exponent,data)
D=2430;k=10^(-8);A=60;v=80;
s=x(1); l=x(2); t=x(3);
y=zeros(1000,1);
for i=1:1000
    y(i)=i/10-0.1;
end
Recordy=zeros(1000,1);
for j=1:1000
    L1=0;i=1;
    while i<=n-1
        L1=L1+(s/(A*sqrt(4*pi*D*(data(i,1)-t))))*exp(-((data(i,2)-l-v*(data(i,1)-t))^2)/(4*D*(data(i,1)-t))-data(i,3))^2 ...
            +y(j)*(exp(0.5*((s/(A*sqrt(4*pi*D*(data(i,1)-t))))*exp(-((data(i,2)-l-v*(data(i,1)-t))^2)/(4*D*(data(i,1)-t)))-data(i,3))^2)-b)...
            +(100/(i^(1/9)))*log((y(j)+1));
        i=i+1;
    end
    Recordy(j)=L1-exponent(1)*x(1)-exponent(2)*x(2)-exponent(3)*x(3);
end
y0=find( Recordy ==max( Recordy ));
y1=y0(1)/10-0.1;