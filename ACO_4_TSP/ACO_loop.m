function [tau, bestTour] = ACO_loop (graph, maxIter, antNo, tau, eta, alpha, beta, rho, edgeEliminated, deletedNodes)
% Main loop of ACO

bestFitness = inf;
bestTour = [];

for t = 1 : maxIter

    % Create Ants 
    colony = [];
    colony = createColony(graph, colony, antNo, tau, eta, alpha, beta);
    
    % Calculate the fitness values of all ants 
    for i = 1 : antNo 
        colony.ant(i).fitness = fitnessFunction(colony.ant(i).tour, graph);
    end
    
    % Find the best ant (queen)
    allAntsFitness = [colony.ant(:).fitness];
    [minVal , minIndex] = min(allAntsFitness);

    if minVal < bestFitness 
        bestFitness = colony.ant(minIndex).fitness;
        bestTour = colony.ant(minIndex).tour;
    end
    
    colony.queen.tour = bestTour;
    colony.queen.fitness = bestFitness;
        
    % Update pheromone matrix 
    tau = updatePheromone(tau , colony);  
    
    % Evaporation 
    tau  = (1 - rho) .* tau;
    
    % Display the results 
    outmsg = ['Iteration #', num2str(t), ' Shortest length = ', num2str(colony.queen.fitness)];
    disp(outmsg);

    subplot(1,3,1);    
    title(['Iteration #', num2str(t)]);
    set(gca,'NextPlot','add');

    % Visualize best tour and pheromone concentration
    if mod(t, 25) == 0
        subplot(1,3,2);
        cla;
        set(gca,'NextPlot','add');
        set(gca,'Box','on');
        drawBestTour(colony.queen.tour, graph, edgeEliminated, deletedNodes);
    end
    
    if mod(t, 25) == 0
        subplot(1,3,3);
        cla;
        set(gca,'NextPlot','add');
        set(gca,'Box','on');
        drawPheromone(tau, graph, edgeEliminated, deletedNodes);
    end
    
   drawnow;

end

end
