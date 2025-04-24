close all

x_tilda = 0:0.01:1;
phi_vec = [0.1 1 10 100];
c_mat = lines(length(phi_vec));

for i= 1:length(phi_vec)
% exact solution
c_tilda = cosh(phi_vec(i)*x_tilda)-tanh(phi_vec(i)).*sinh(phi_vec(i)*x_tilda);


figure(1)
plot(x_tilda,c_tilda,'Color',c_mat(i,:)); hold on
ylim([0 1])

% approximate solution (valid for large phi)
x_hat = x_tilda*phi_vec(i);
c_tilda_app = exp(-x_hat);
plot(x_tilda,c_tilda_app,'o','Color',c_mat(i,:)); hold on


end