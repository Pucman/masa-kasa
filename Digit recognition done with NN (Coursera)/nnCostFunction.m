function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

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
J_1 = sum(J_temp)/m;

Theta1_temp = Theta1;
Theta1_temp(:,1) = 0;

Theta2_temp = Theta2;
Theta2_temp(:,1) = 0;
% Theta1_temp = zeros(size(Theta1,1),size(Theta1,2));
% for s1 = 1:size(Theta1,1);
	% for s2 = 2:size(Theta1,2);
		% Theta1_temp(s1,s2) = Theta1(s1,s2)^2;
	% end
% end

% Theta2_temp = zeros(size(Theta2,1),size(Theta2,2));
% for s3 = 1:size(Theta2,1);
	% for s4 = 2:size(Theta2,2);
		% Theta2_temp(s3,s4) = Theta2(s3,s4)^2;
	% end
% end

% J = J_1 + (lambda/(2*m))*(sum(sum(Theta1_temp))+ sum(sum(Theta2_temp)));
J = J_1 + (lambda/(2*m))*(Theta1_temp(:)'*Theta1_temp(:)+ Theta2_temp(:)'*Theta2_temp(:));

delta1 = zeros(size(Theta1));
delta2 = zeros(size(Theta2));
for t = 1:m;
	a1t = a1(t,:)'; % 401x1
	a2t = a2(t,:)'; % 26x1
	
	ht = h(t,:)'; % 10x1
	yVecT = y(t,:)'; % 10x1
	
	d3t = ht - yVecT;% 10x1
	z2t = [1; Theta1 * a1t]; % 26x1
	d2t = Theta2' * d3t .* sigmoidGradient(z2t); %26x1
	
	delta1 = delta1 +  (a1t*d2t(2:end)')';
	delta2 = delta2 + (a2t*d3t')';
	
	% d_3 = h(t,:)' - y(t,:)';
	% d_2 = Theta2'*d_3.*sigmoidGradient(z2(t,:));
	
	% d_2 = d_2(2:end);
	% delta1 = delta1 + d_2*a1(t,:)';
	% delta2 = delta2 + d_3 * a2(t,:)';
	
	% a1t = a1(t,:)';
	% a2t = a2(t,:)';
	% ht = h(t,:)';
	% yVecT = y(t,:)';
	% d3t = ht - yVecT;
	% z2t = [1; Theta1 * a1t];
	% d2t = Theta2' * d3t .* sigmoidGradient(z2t);
	% delta1 = delta1 + d2t(2:end) * a1t';
	% delta2 = delta2 + d3t * a2t';
end
Theta1_grad = delta1./m + (lambda/m)* [zeros(size(Theta1,1),1) Theta1(:,2:end)];
Theta2_grad = delta2./m + (lambda/m)* [zeros(size(Theta2,1),1) Theta2(:,2:end)];







% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
