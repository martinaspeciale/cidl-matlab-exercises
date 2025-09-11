% script main.m

% This demo shows how to solve a Traveling Salesman Problem (TSP) 
% using Ant Colony Optimization (ACO).

% In the second part of the script, we will show an interesting feature of ACO:
% it allows to easily compute the new optimal solution in case one of the
% arc is deleted. This is possible thanks to the reuse of the last
% pheromore matrix (a feature that is not present neither in PSO nor in GAs).


%% Clear and close everything
clear all
close all
clc

%% Problem preparation 

% Create the graph 
edgeEliminated = false;
deletedNodes = [0, 0];

x = [7, 5, 7, 9, 4, 6, 8, 10, 3, 5, 7, 9, 11, 4, 6, 8, 10, 5, 7, 9, 7];
y = [1, 3, 3, 3, 5, 5, 5, 5, 7, 7, 7, 7, 7, 9, 9, 9, 9, 11, 11, 11, 13];

graph = createGraph(x, y);

% Saves the coordinates of the midpoints of each edge of the graph in two arrays
xMidpointEdge = midpoint(x);
yMidpointEdge = midpoint(y);

% Draw the graph 
figure 
 
subplot(1,3,1)
set(gca,'NextPlot','add');
set(gca,'Box','on');
drawGraph(graph, edgeEliminated, deletedNodes); 

%% ACO algorithm 

%% Initial parameters of ACO 

maxIter = 500;
antNo = 50;

tau0 = 10 * 1 / (graph.n * mean(graph.edges(isfinite(graph.edges))));   % Initial pheromone concentration
tau = zeros(graph.n, graph.n);                                          % Pheromone matrix 
finite_edges_indices = isfinite(graph.edges);
tau(finite_edges_indices) = tau0;

eta = zeros(size(graph.edges));
finite_edges_indices = isfinite(graph.edges);
eta(finite_edges_indices) = 1 ./ graph.edges(finite_edges_indices);     % Desirability of each edge 

rho = 0.8;      % Evaporation rate 
alpha = 0.5;    % Pheromone exponential parameters 
beta = 0.5;     % Desirability exponential parameter


%% Main loop of ACO 
[tau, queenTour] = ACO_loop(graph, maxIter, antNo, tau, eta, alpha, beta, rho, edgeEliminated, deletedNodes);



%--- SECOND PART -------------------------------------

subplot(1,3,2);
text(5, -1.2, 'SECOND PART: Click over the arc you want to delete (please chose it among the ones in the optimal tour)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'red', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');

% The user can click on a garph
[a, b] = ginput(1);

% Check which edge is closest to the point clicked by the user (by comparing the coordinates with the coordinates of the midpoints of the edges)
deletedEdge = closeEdge(a, b, xMidpointEdge, yMidpointEdge);
deletedNodes = findNode(deletedEdge);

% Delete the identified edge
graph.edges(deletedNodes(1), deletedNodes(2)) = inf;
graph.edges(deletedNodes(2), deletedNodes(1)) = inf;

edgeEliminated = true;
subplot(1,3,1)
drawGraph(graph, edgeEliminated, deletedNodes); 

subplot(1,3,2);
drawBestTour(queenTour, graph, edgeEliminated, deletedNodes);

subplot(1,3,3);
drawPheromone(tau , graph, edgeEliminated, deletedNodes);

%% New parameters of ACO

maxIter = 250;

tau(finite_edges_indices) = tau(finite_edges_indices) + tau0;

eta = zeros(size(graph.edges));
finite_edges_indices = isfinite(graph.edges);
eta(finite_edges_indices) = 1 ./ graph.edges(finite_edges_indices);  % desirability of each edge 

%% New loops of ACO

[tau, queenTour] = ACO_loop(graph, maxIter, antNo, tau, eta, alpha, beta, rho, edgeEliminated, deletedNodes);
