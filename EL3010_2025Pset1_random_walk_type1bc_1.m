% EL3010 2025
% Pset 1 - random walks in 1D Dirichlet BC
% 2025.03.09
% Ju Song

clear; clc; close all

%% Config

L = 20;
dx = 1;
x_vec = 0:dx:L;

N_x0 = 1000;
N_x1 = 0; % for simplicity

t_end = 1000; % number of time steps
dt = 1;
t_vec = 0:dt:t_end;
M = length(t_vec);
m_hist = [1,5,10,20,50,100,200];%[200,400,600,800,1000];%[1,5,10,20,50,100,200];%[1,5,10,20,50,100,200,300,500,1000];



%% Initialization
x_mat = zeros(N_x0,M);
d_avg = zeros(1,M);
N = N_x0;
J = zeros(1,M);

%% random walk time steps
for m = 1:M % loop over time steps
    
    % generate random walks for N_m particles
    dx_now =  dx*(2*unidrnd(2,N,1)-3); % 1 or -1
    if m ~=1
    x_mat(:,m) = x_mat(:,m-1) + dx_now;

    % flux at L
    J(1,m) = sum(x_mat(:,m) >= L);

    % detect particles out of domain and remove (including x =L)
    detect = x_mat(:,m) >= L | x_mat(:,m) <= 0;
    x_mat(detect,:) = [];

    % keep number of the particles at x0
    x_mat_add = [NaN(N_x0,m-1) zeros(N_x0,M-(m-1))];
    x_mat = [x_mat; x_mat_add];
    end

    % calculate 
    d_vec_now = sqrt(x_mat(:,m).^2);
    d_avg(1,m) = mean(d_vec_now);
    N_vec(1,m) = sum(~isnan(x_mat(:,m)));
    

    % update loop
    N = size(x_mat(:,m),1);
    
    if ismember(m,m_hist)
        
        if m == m_hist(1)
        legend_cell = {['step ' num2str(m)]};
        else
        legend_cell = [legend_cell, {['step ' num2str(m)]}];
        end


        figure(1);
        h_now = histogram(x_mat(:,m),[x_vec, L+1],'FaceAlpha',0.333); hold on
        uistack(h_now,'bottom')
        xlabel('position')
        ylabel('number')
        legend(flip(legend_cell,2))
        figure(2);
        plot(x_vec,h_now.Values); hold on
        xlabel('position')
        ylabel('number')
        legend(legend_cell)

    end

    
end

return

%% presentations
% 
figure(3)
plot(t_vec,d_avg)
xlabel('time step')
ylabel('avg distance')
figure(4)
plot(t_vec,N_vec)
xlabel('time step')
ylabel('totoal number of particles')
figure(5)
plot(t_vec,J); hold on
plot(t_vec,movmean(J,100),'linewidth',2)
legend({'flux','flux avg (dt=100)'})
xlabel('time step')
ylabel('flux at x(end)')
% figure(1); hold on
% for m = [1 10 20 30]
% histogram(x_mat(:,m), [x_vec, L+1]); hold on
% end
