function average_error = grad_check(fun, theta0, varargin)
% 检查梯度计算函数是否正确
% 要做的事就是加载数据集，设置好参数
% 像调用minFunc那样调用grad_check即可观察结果(除了option参数不需要)
% 误差大小没太大关系，只要能能保证梯度计算函数计算的结果
% 与估计的结果前4位有效数字相同即可认为梯度计算是正确的
  delta=1e-3; 
  sum_error=0;
  
  n = length(theta0);

  fprintf('grad checking\n');
  fprintf('         i             err');
  fprintf('           g_est               g               f\n')

  T = theta0;
  [f,g] = fun(T, varargin{:});

  for i=1:n
    T0=T; T0(i) = T0(i)-delta;
    T1=T; T1(i) = T1(i)+delta;

    f0 = fun(T0, varargin{:});
    f1 = fun(T1, varargin{:});

    g_est = (f1-f0) / (2*delta);
    error = abs(g(i) - g_est);

    fprintf('%10d %15g %15f %15f %15f\n', ...
            i,error,g_est,g(i),f);

    sum_error = sum_error + error;
  end

  average_error=sum_error/n;
  fprintf('grad checked\n');
