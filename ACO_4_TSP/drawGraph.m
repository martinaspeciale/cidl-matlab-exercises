function []  = drawGraph( graph, edgeEliminated, eliminatedNodes)
% To visualize the nodes and edges of the graph

% To visualize the edges of the graph
for i = 1 : graph.n - 1
    for j =  i+1 : graph.n
    
        x1 = graph.node(i).x;
        y1 = graph.node(i).y;
        
        x2 = graph.node(j).x;
        y2 = graph.node(j).y;
        
        X = [x1 , x2]; 
        Y = [y1 , y2];
        
        if isfinite(graph.edges(i, j))
            plot( X , Y , '-k', 'LineWidth', 1);
        end
    end
end

% If an edge has been deleted, its color will be turned into lightgray
if edgeEliminated == true
    x1 = graph.node(eliminatedNodes(1)).x;
    y1 = graph.node(eliminatedNodes(1)).y;
        
    x2 = graph.node(eliminatedNodes(2)).x;
    y2 = graph.node(eliminatedNodes(2)).y;
        
    X = [x1 , x2]; 
    Y = [y1 , y2];

    plot( X , Y , '-', 'Color', [0.5, 0.5, 0.5], 'LineWidth', 0.5);
end

% To visualize the nodes of the graph
for i = 1 : (graph.n)
    X = [graph.node(i).x];
    Y = [graph.node(i).y];
    plot(X,Y, 'ok', 'MarkerSize', 10, 'MarkerEdgeColor' , 'b' , 'LineWidth', 1, 'MarkerFaceColor' , 'c');
end

title ('Al nodes and edges')
set(gca,'XTick',[]);
set(gca,'YTick',[]);

end
