function [deletedEdge] = closeEdge(a, b, xMidpointEdge, yMidpointEdge)
% To find the edge closest to the position where the user clicked the mouse

minDistance = inf;
for i = 1 : 48
    distance = sqrt((a - xMidpointEdge(i)).^2 + (b - yMidpointEdge(i)).^2);

    if distance < minDistance
        minDistance = distance;
        deletedEdge = i;
    end
end
end
