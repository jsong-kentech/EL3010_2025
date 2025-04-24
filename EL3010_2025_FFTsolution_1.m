clear; clc; close all

x_vec = linspace(0,1,201);

N = 200;

n_plot = [1, 5, 20, 100, 200];


plot(x_vec, 1-x_vec); hold on

theta_n = 0;

for i = 1:N
    
    c_n = sqrt(2)/(i*pi);

    phi_n = sqrt(2)*sin(i*pi*x_vec);

    theta_n = theta_n + c_n*phi_n;


    if ismember(i,n_plot)
        plot(x_vec,theta_n); hold on

    end

end


legend({'N=1','N=5','N=20','N=100','N=100'})
ylim([0 1.2])
