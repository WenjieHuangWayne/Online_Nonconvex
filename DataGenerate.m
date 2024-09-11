dr=zeros(930,3);
D=2430;k=10^(-8);A=60;v=80;
s=1300000; l=-22106; t=-215;% Information of source
for i=1:30
    for j=1:30
        dr(30*i+j,2)=-14216.3+362.25*(10/3)*i;
        dr(30*i+j,1)=-145+5.78*(10/3)*j;
    end
end
% Averagly take point from a given domain.
for i=1:930
    dr(i,3)=(s/(A*sqrt(4*pi*D*(dr(i,1)-t))))*exp(-((dr(i,2)-l-v*(dr(i,1)-t))^2)/(4*D*(dr(i,1)-t)));
end
% Concentration Calculation
rand=normrnd(0,0.5,930,1);
% Add random error
dr(:,3)=dr(:,3)+rand;
for i=1:930
    if dr(i,3)<=0
        dr(i,3)=0;
    end
end