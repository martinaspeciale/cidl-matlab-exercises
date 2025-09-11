function [graph]  = createGraph(x, y)
% Create the graph
   
graph.n = length(x); 

for i = 1 : graph.n
    graph.node(i).x = x(i);
    graph.node(i).y = y(i);
end

% Sets the weights of all edges to +inf
graph.edges = inf(  graph.n , graph.n );

graph = addEdge(graph, 1, 2, 8);
graph = addEdge(graph, 1, 3, 3);
graph = addEdge(graph, 1, 4, 5);
graph = addEdge(graph, 2, 3, 6);
graph = addEdge(graph, 2, 5, 1);
graph = addEdge(graph, 2, 6, 6);
graph = addEdge(graph, 3, 4, 4);
graph = addEdge(graph, 3, 6, 6);
graph = addEdge(graph, 3, 7, 5);
graph = addEdge(graph, 4, 7, 4);
graph = addEdge(graph, 4, 8, 5);
graph = addEdge(graph, 5, 6, 1);
graph = addEdge(graph, 5, 9, 9);
graph = addEdge(graph, 5, 10, 4);
graph = addEdge(graph, 6, 7, 7);
graph = addEdge(graph, 6, 10, 2);
graph = addEdge(graph, 6, 11, 9);
graph = addEdge(graph, 7, 8, 1);
graph = addEdge(graph, 7, 11, 10);
graph = addEdge(graph, 7, 12, 4);
graph = addEdge(graph, 8, 12, 5);
graph = addEdge(graph, 8, 13, 10);
graph = addEdge(graph, 9, 10, 8);
graph = addEdge(graph, 9, 14, 7);
graph = addEdge(graph, 10, 11, 5);
graph = addEdge(graph, 10, 14, 7);
graph = addEdge(graph, 10, 15, 2);
graph = addEdge(graph, 11, 12, 9);
graph = addEdge(graph, 11, 15, 8);
graph = addEdge(graph, 11, 16, 7);
graph = addEdge(graph, 12, 13, 3);
graph = addEdge(graph, 12, 16, 8);
graph = addEdge(graph, 12, 17, 5);
graph = addEdge(graph, 13, 17, 9);
graph = addEdge(graph, 14, 15, 6);
graph = addEdge(graph, 14, 18, 2);
graph = addEdge(graph, 15, 16, 8);
graph = addEdge(graph, 15, 18, 7);
graph = addEdge(graph, 15, 19, 9);
graph = addEdge(graph, 16, 17, 2);
graph = addEdge(graph, 16, 19, 9);
graph = addEdge(graph, 16, 20, 3);
graph = addEdge(graph, 17, 20, 5);
graph = addEdge(graph, 18, 19, 10);
graph = addEdge(graph, 18, 21, 4);
graph = addEdge(graph, 19, 20, 9);
graph = addEdge(graph, 19, 21, 3);
graph = addEdge(graph, 20, 21, 8);

end