syms x1 x2 x3
x=[x1,x2,x3]';
T=500;
Recordx=zeros(3,T);
Recordy=zeros(1,T);
Recordf=zeros(1,T);
data=dr;
%algorithm
parfor n = 2:T
exponent=[exprnd(T^(2/3),1,1),exprnd(T^(2/3),1,1),exprnd(T^(2/3),1,1)];
fun=@(x)oracleminimax(x,n,2.5,exponent,data);
fun0=@(x)oracleminimax0(x,n,2.5,data);
ub = [1500000; -20000; -200]'; % Given upper bound
lb = [1000000;-25000;-250]'; % Given lower bound
opt=gaoptimset('Generations', 3000, 'PopulationSize', 50);
[x1,fval,exitflag] = ga(fun,3,[],[],[],[],lb,ub,[],opt);
Recordx(:,n)=x1;
Recordy(:,n)=Ry(x1,n,2.5,exponent,data);
[x0,fval0,exitflag0] = ga(fun0,3,[],[],[],[],lb,ub,[],opt);
Recordf(n)=fval0;
end
%measure
Recordr=zeros(1,T);
for n=2:T
j=2;His=0;
while j<=n-1
His=His+ade(Recordx(:,j),Recordy(j),j,2.5,data);
j=j+1;
end
Recordr(n)=(His-Recordf(n))/n;
end
Recordr=abs(Recordr);