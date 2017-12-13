close all;
load('5.mat');

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

type_train_func = 12;    % Функция обучения: 
%1-traingd, 2-traingda, 3-traingdm, 4-traingdx, 5-trainrp, 
%6-traincgf, 7-traincgb, 8-traincgp, 9-trainscg, 10-trainlm, 
%11-trainbfg, 12-trainoss, 13-trainbr

net = newff(P, T, 20);
net = init(net);
net = set_train_param(net, type_train_func);
net = train(net, P(trainIdx), T(trainIdx));

Y = sim(net, P(testIdx));
err = perform(net, T(testIdx), Y)

function net = set_train_param(net, type_train_func)
    trainf_fcns = {'traingd','traingda', 'traingdm', 'traingdx', 'trainrp'... % 1-5
        'traincgf', 'traincgb', 'traincgp', 'trainscg',... % 6-9
        'trainlm', 'trainbfg', 'trainoss', 'trainbr' };   % 10-13
    net.trainfcn = trainf_fcns{type_train_func};        % Функция обучения

    trainParam = net.trainParam;

    trainParam.epochs = 2000;
    trainParam.time = Inf;
    trainParam.goal = 0;
    trainParam.min_grad = 1e-05;
    trainParam.max_fail = 10;
    
    % Параметры визуализации обучения
    trainParam.showWindow = true;       % Показывать окно или нет
    trainParam.showCommandLine = false; % Выводить в командную строку или нет
    trainParam.show = 25;               % Частота обновления - через сколько эпох

    switch type_train_func
        case 1
            % traingd - Градиентный спуск
            trainParam.lr = 0.01;               % !Скорость обучения
        case 2
            % traingda - Градиентный спуск c адаптацией
            trainParam.lr = 0.01;               % !Скорость обучения (изначальная)
            trainParam.lr_inc = 1.05;           % !Коэффициент увеличения скорости обучения
            trainParam.lr_dec = 0.7;            % !Коэффициент уменьшения скорости обучения
            trainParam.max_perf_inc  = 1.04;    % !Допустимый коэффициент изменения ошибки 
                                                    % при его превышении скорость уменьшается в lr_dec раз, коэффициенты не изменяются, в противном случае коэффициенты изменяются
                                                    % Если текущая ошибка меньше предыдущей, то скорость увеличивается в lr_inc раз
        case 3
            % traingm - Градиентный спуск c адаптацией
            trainParam.lr = 0.02;               % !Скорость обучения
            trainParam.mc = 0.8;                % !Момент инерции (от 0 до 1), чем он больше тем более плавное изменение коэффициентов
                                                    % При mc=0 traingdm переходит в traingd
        case 4
            % traingx - Градиентный спуск c адаптацией и моментом
            trainParam.lr = 0.01;               % !Скорость обучения (изначальная)
            trainParam.mc = 0.8;                % !Момент инерции
            trainParam.lr_inc = 1.05;           % !Коэффициент увеличения скорости обучения
            trainParam.lr_dec = 0.7;            % !Коэффициент уменьшения скорости обучения
            trainParam.max_perf_inc  = 1.02;    % !Допустимый коэффициент изменения ошибки 
        case 5
            % trainrp
            trainParam.lr = 0.01;               % !Скорость обучения (изначальная)
            % Параметры алгоритма (для поиска значения delta)
            trainParam.delt_inc = 1.2;          % Increment to weight change
            trainParam.delt_dec = 0.5;          % Decrement to weight change
            trainParam.delta0 = 0.5;           % Initial weight change
            trainParam.deltamax = 50.0;         % Maximum weight change
        case {6,7,8, 11, 12}
            % traincgf, traincgp, traincgb, trainbfg, trainoss
            if ~isempty(find(type_train_func == [6 7 8], 1))
                trainParam.searchFcn = 'srchcha';   % !Функция одномерного линейного поиска (srchbac, srchbre, srchgol, srchhyb)
            else
                trainParam.searchFcn = 'srchbac';   % !Функция одномерного линейного поиска (srchbac, srchbre, srchgol, srchhyb)
            end
            % Параметры функции одномерного поиска
            trainParam.scale_tol = 20;         % Divide into delta to determine tolerance for linear search.
            trainParam.alpha = 0.001;           % Scale factor that determines sufficient reduction in perf
            trainParam.beta = 0.1;              % Scale factor that determines sufficiently large step size
            trainParam.delta = 0.01;            % Initial step size in interval location step
            trainParam.gama = 0.1;              % Parameter to avoid small reductions in performance, usually set to 0.1 (see srch_cha)
            trainParam.low_lim = 0.1;           % Lower limit on change in step size
            trainParam.up_lim = 0.8;             % Upper limit on change in step size
            trainParam.max_step = 100;           % Maximum step length
            trainParam.min_step = 1.0e-6;        % Minimum step length
            trainParam.bmax = 26;               % Maximum step size
            if type_train_func == 11
                trainParam.batch_frag = 0;          % In case of multiple batches, they are considered independent. Any nonzero value implies a fragmented batch, so the final layer's conditions of a previous trained epoch are used as initial conditions for the next epoch.
            end
        case 9
            % trainscgf
            trainParam.sigma = 5e-5;            % Изменение весов для аппроксимации второй производной
            trainParam.lambda = 5e-7;           % Параметр для регуляризации при плохой обусловенности матрицы Гессе
        %-------------------------------------------------------%
        %-------Методы переменной метрики-----------------------%
        %-------------------------------------------------------%
        case {10, 13}
            % trainlm, trainbr
            % Параметры алгоритма (для поиска значения mu)
            trainParam.mu = 0.001;              % Initial mu
            trainParam.mu_dec = 0.1;            % mu decrease factor
            trainParam.mu_inc = 10;             % mu increase factor
            trainParam.mu_max = 1e10;           % Maximum mu
    end;
    net.trainParam = trainParam;
end