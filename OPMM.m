clc
clear

% Hyper parameter setting
T=500;
sigma=T^(-1/4);
alpha=T^(1/4);
load('C:\Users\DELL\AppData\Local\Temp\Simulate_data.mat');
data=dr;

% Optimization setting
syms x1 x2 x3
x=[x1,x2,x3]';
Recordx=zeros(3, T); 
Recordy=zeros(1,T);
Recordf=zeros(1,T);
Recordy(1) = 0;
Recordx(:, 1) = [1400000; -21000; -240];
ub = [1500000; -20000; -200]; % Given upper bound
lb = [1000000;-25000;-250]; % Given lower bound
RecordF = zeros(3, T);
RecordG = zeros(3, T);
t = 1;

% Optimization Process
while t<=T
    % OPMM solution
    f = @(x)ade(x,t,data);
    g = @(x)adecons(x,Recordy(t),t,1.3,data);
    RecordF(:, t) = grad_numerical(f,Recordx(:, t),10^(-6)); 
    RecordG(:, t) = grad_numerical(g,Recordx(:, t),10^(-6)); 
    Theta_0=hessian_numerical(f,Recordx(:, t),10^(-6),10^(-6));
    Theta_1=hessian_numerical(g,Recordx(:, t),10^(-6),10^(-6));
    q_0 = @(x) f(Recordx(:, t))+RecordF(1, t)*(x(1)-Recordx(1, t))+RecordF(2, t)*(x(2)-Recordx(2, t))+RecordF(3, t)*(x(3)-Recordx(3, t))+...
        +Theta_0(1, 1)*(x(1)-Recordx(1, t))^2+Theta_0(2, 2)*(x(2)-Recordx(2, t))^2+Theta_0(3, 3)*(x(3)-Recordx(3, t))^2+...
        +2*Theta_0(1, 2)*(x(1)-Recordx(1, t))*(x(2)-Recordx(2, t))+2*Theta_0(1, 3)*(x(1)-Recordx(1, t))*(x(3)-Recordx(3, t))+...
        +2*Theta_0(2, 3)*(x(2)-Recordx(2, t))*(x(3)-Recordx(3, t));
    q_1 = @(x) g(Recordx(:, t))+RecordG(1, t)*(x(1)-Recordx(1, t))+RecordG(2, t)*(x(2)-Recordx(2, t))+RecordG(3, t)*(x(3)-Recordx(3, t))+norm(x-Recordx(:, t))^2+...
        +Theta_1(1, 1)*(x(1)-Recordx(1, t))^2+Theta_1(2, 2)*(x(2)-Recordx(2, t))^2+Theta_1(3, 3)*(x(3)-Recordx(3, t))^2+...
        +2*Theta_1(1, 2)*(x(1)-Recordx(1, t))*(x(2)-Recordx(2, t))+2*Theta_1(1, 3)*(x(1)-Recordx(1, t))*(x(3)-Recordx(3, t))+...
        +2*Theta_1(2, 3)*(x(2)-Recordx(2, t))*(x(3)-Recordx(3, t));
    Ora = @(x) q_0(x)+(1/2*sigma)*(max(Recordy(t)+sigma*q_1(x), 0)^2-Recordy(t)^2)+(alpha/2)*norm(x-Recordx(:, t))^2;
    opt=gaoptimset('Generations', 3000, 'PopulationSize', 50);
    [x1,fval,~] = ga(Ora,3,[],[],[],[],lb,ub,[],opt);
    Recordx(:,t+1)=x1;
    Recordy(t+1)=max(Recordy(t)+sigma*q_1(Recordx(:,t+1)), 0);

    t = t+1;

end

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