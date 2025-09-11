function [graph] = addEdge (graph, i, j, weight)
% defines the weight on the edge (i, j),
% which is the edge connecting node i with node j.

graph.edges(i, j) = weight;
graph.edges(j, i) = weight;

end
