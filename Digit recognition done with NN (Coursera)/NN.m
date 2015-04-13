%% Initialization
clear ; close all; clc

addpath ('G:\Programowanie\Text recognition\First try');

data = load('semeion.data');
m = size(data,1);
data = data(randperm(m),:);

input_layer_size  = 256;  % 16x16 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 10;   % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)


X_test = data(1:318,1:256);
y_temp_test = data(1:318,257:266);
[max_y_t i_max_y_t] = max(y_temp_test');
y_test = i_max_y_t';


X = data(319:1593,1:256);
y_temp = data(319:1593,257:266);
[max_y i_max_y] = max(y_temp');
y = i_max_y';



%% ================ Part 1: Initializing Pameters ================


fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%% =================== Part 2: Training NN ===================

%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 50);

%  You should also try different values of lambda
lambda = 1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
				 


%% ================= Part 10: Implement Predict =================
fprintf('\nSaving parameters... \n')
save Theta1_NN.mat Theta1
save Theta2_NN.mat Theta2

fprintf('\nChecking accuracy... \n')
pred_test = predict(Theta1, Theta2, X_test);
pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
fprintf('\nTest Set Accuracy: %f\n', mean(double(pred_test == y_test)) * 100);