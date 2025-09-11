function [colony] = createColony( graph, colony , antNo, tau, eta, alpha,  beta)
% Create the path of each ant

nodeNo = graph.n;
nodesReached = [];
completeTour = [];
numNodesReached = 0;

for i = 1 : antNo
    
    % select a random node
    initial_node = randi([1, nodeNo]);  
    colony.ant(i).tour(1) = initial_node;
    currentNode = initial_node;
    
    while numNodesReached ~= nodeNo
              
               currentNode =  colony.ant(i).tour(end);

               for k = 1 : length(nodesReached) + 1
                   if k == length(nodesReached) + 1
                       nodesReached = [nodesReached, currentNode];
                       numNodesReached = numNodesReached + 1;
                       break;
                    elseif nodesReached(k) == currentNode
                       break;
                   end
               end

               if numNodesReached == nodeNo
                  break;
               end
               
               P_allNodes = tau(currentNode, : ) .^ alpha .* eta(currentNode, : )  .^ beta;
               P_allNodes(colony.ant(i).tour) = 1e-10;  % assing almost 0 to all the nodes visited so far

               for j = 1 : nodeNo
                   if isinf(graph.edges(currentNode, j))
                       P_allNodes(j) = 0;
                   end
               end

               P = P_allNodes ./ sum(P_allNodes);
               
               nextNode = rouletteWheel(P); 
               colony.ant(i).tour = [colony.ant(i).tour, nextNode];
    end
    
    nodesReached = [];
    numNodesReached = 0;

    % complete the tour 
    while currentNode ~= initial_node

               currentNode =  colony.ant(i).tour(end);

               if currentNode == initial_node
                  break;
               end
               
               P_allNodes = tau(currentNode, : ) .^ alpha .* eta(currentNode, : )  .^ beta;
               P_allNodes(completeTour) = 1e-7;  % assing almost 0 to all the nodes visited so far
               P = P_allNodes ./ sum(P_allNodes);
               
               nextNode = rouletteWheel(P); 
               colony.ant(i).tour = [colony.ant(i).tour, nextNode];
               completeTour = [completeTour, nextNode];

    end

    completeTour = [];

end

end