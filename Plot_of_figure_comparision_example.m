load('C:\Users\DELL\Desktop\rf1.mat')
Recordr=zeros(1,T);
for n=1:T
    j=1;His=0;
    while j<=n
        His=His+ade(Recordx(:,j),j,data);
        j=j+1;
    end
    Recordr(n)=(His-Recordf(n))/n;
end
Recordr=abs(Recordr);
plot(Recordr)

%
Recordr=zeros(1,T);
for n=1:T
    j=1;His=0;
    while j<=n
        His=His+adecons(Recordx(:,j),1,j,1.3,data);
        j=j+1;
    end
    Recordr(n)=(His);
end
Recordr=max(Recordr,0);
plot(Recordr)

% Regret evaluation
Recordr=zeros(1,T);
for n=1:T
    j=1;His=0;
    while j<=n
        His=His+ademinimax(Recordx(:,j),Recordy(j),j,1.3,data);
        j=j+1;
    end
    Recordr(n)=(His-Recordf(n))/n;
end
Recordr=abs(Recordr);
plot(Recordr)

figure=zeros(50,1);
for i=1:50
    figure(i)=Recordr(10*i);
end
axis=1:1:500;
figure1=zeros(50,1);
for i=1:50
    figure1(i)=Recordr1(10*i);
end
gt = plot(axis,Recordr);
hold on
%gt1 = plot(axis,Recordr1);
set(gt, 'Color',[200/255,110/255,0/255])
%set(gt1, 'Color',[139/255,0/255,18/255])
set(gt, 'linewidth', 2.5)
%set(gt1, 'linewidth', 2.5)
set(gca, 'fontsize', 20)
xlabel('Period $n$', 'interpreter','latex', 'FontSize', 20);
ylabel('$R_n/n$','interpreter','latex', 'FontSize', 20);
grid minor
legend('Baseline','Algorithm 1')
