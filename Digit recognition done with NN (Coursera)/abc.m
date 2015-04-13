function J_temp_sum = abc(X, y, Theta1, Theta2)
m = size(X, 1);
a1 = [ones(m, 1) X];
z2 = a1 * Theta1';
a2 = sigmoid(z2);
a2 = [ones(m, 1) a2];
z3 = a2 * Theta2';
h = sigmoid(z3);

ym = zeros(size(y,1),max(y));

for n = 1:size(y,1);
	ym(n,y(n)) = 1;
end
y = ym;

J_temp = zeros(m,1);
for temp = 1:m;
	J_temp(temp) = (-y(temp,:)*log(h(temp,:))' - (1-y(temp,:))*log(1-h(temp,:))');
end
J_temp_sum = sum(J_temp)
end
