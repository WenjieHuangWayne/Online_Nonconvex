function [c]=ade(x,y,i,b,data)
dr=data;
D=2430;k=10^(-8);A=60;v=80;
s=x(1); l=x(2); t=x(3);
c=((s/(A*sqrt(4*pi*D*(dr(i,1)-t))))*exp(-((dr(i,2)-l-v*(dr(i,1)-t))^2)/(4*D*(dr(i,1)-t)))-dr(i,3))^2 ...
            +y*(exp(((s/(A*sqrt(4*pi*D*(dr(i,1)-t))))*exp(-((dr(i,2)-l-v*(dr(i,1)-t))^2)/(4*D*(dr(i,1)-t)))-dr(i,3))^2)-b);