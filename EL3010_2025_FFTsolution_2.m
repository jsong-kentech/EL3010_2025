

x_vec = linspace(0,1,1001);

legend_cell{1} = '1-x';
figure(1)
%plot(x_vec,1-x_vec); hold on


N = 100;
f_n = zeros(size(x_vec));

n_plot = [1,10, 20,100];


for n = 1:N

    l_n = n*pi;
    c_n = sqrt(2)/l_n;
    p_n = sqrt(2)*sin(l_n*x_vec);

    f_n = f_n + c_n*p_n;


    if ismember(n,n_plot)
        plot(x_vec,f_n); hold on
        %legend_cell = {legend_cell, num2str(n)};
        %legend(legend_cell)

    end

end

%%
clear; clc;

x = linspace(0,1,101);
y = linspace(0,1,51)';

N = 100;
r = 0.2;
theta_n = zeros(length(y),length(x));


n_plot = [0,4,20,100];

figure(2)

k_plot=1;
for n = 0:N

    l_n = (n+0.5)*pi;
    
    phi_n_yvec = sqrt(2)*cos((l_n*y));
    phi_n_mat = repmat(phi_n_yvec,1,length(x));

    si_n_xvec = (sqrt(2)/l_n*sin(l_n))*(cosh(l_n*r*x)-coth(l_n*r)*sinh(l_n*r*x));
    si_n_mat = repmat(si_n_xvec,length(y),1);

    theta_n = theta_n + phi_n_mat.*si_n_mat;

    if ismember(n,n_plot)
        subplot(1,4,k_plot)
        h = surf(x,y,theta_n); hold on
        set(h,'edgecolor','none')
        %legend_cell = {legend_cell, num2str(n)};
        %legend(legend_cell)
        k_plot = k_plot +1;
        daspect([r 1 1])

    end


end
set(gcf,'position',[0 0 2000 500])