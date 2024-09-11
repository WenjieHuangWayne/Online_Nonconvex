data=dr;
Recordmean=zeros(3,100);
T=500;
parfor n = 1:100
        exponent=[exprnd(T^(2/3),1,1),exprnd(T^(2/3),1,1),exprnd(T^(2/3),1,1)];
        fun=@(x)oracle(x,500,exponent,data);
        ub = [1500000; -20000; -200]';        % Given upper bound
        lb = [1000000;-25000;-250]';      % Given lower bound
        opt=gaoptimset('Generations', 3000, 'PopulationSize', 50);
        [x1,fval,exitflag] = ga(fun,3,[],[],[],[],lb,ub,[],opt);
        Recordmean(:,n)=x1;
end