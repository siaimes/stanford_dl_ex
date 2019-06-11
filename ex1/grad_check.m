function average_error = grad_check(fun, theta0, varargin)
% ����ݶȼ��㺯���Ƿ���ȷ
% Ҫ�����¾��Ǽ������ݼ������úò���
% �����minFunc��������grad_check���ɹ۲���(����option��������Ҫ)
% ����Сû̫���ϵ��ֻҪ���ܱ�֤�ݶȼ��㺯������Ľ��
% ����ƵĽ��ǰ4λ��Ч������ͬ������Ϊ�ݶȼ�������ȷ��
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
