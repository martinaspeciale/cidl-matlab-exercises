function [eliminatedNodes] = findNode(deletedEdge)
% this function finds the nodes corresponding to the deleted edge 

numEdges = 48;
for i = 1 : numEdges
    if i ~= deletedEdge
        continue;
    elseif i == 1
        eliminatedNodes = [1, 2];
        break;
    elseif i == 2
        eliminatedNodes = [1, 3];
        break;
    elseif i == 3
        eliminatedNodes = [1, 4];
        break;
    elseif i == 4
        eliminatedNodes = [2, 3];
        break;
    elseif i == 5
        eliminatedNodes = [2, 5];
        break;
    elseif i == 6
        eliminatedNodes = [2, 6];
        break;
    elseif i == 7
        eliminatedNodes = [3, 4];
        break;
    elseif i == 8
        eliminatedNodes = [3, 6];
        break;
    elseif i == 9
        eliminatedNodes = [3, 7];
        break;
    elseif i == 10
        eliminatedNodes = [4, 7];
        break;
    elseif i == 11
        eliminatedNodes = [4, 8];
        break;
    elseif i == 12
        eliminatedNodes = [5, 6];
        break;
    elseif i == 13
        eliminatedNodes = [5, 9];
        break;
    elseif i == 14
        eliminatedNodes = [5, 10];
        break;
    elseif i == 15
        eliminatedNodes = [6, 7];
        break;
    elseif i == 16
        eliminatedNodes = [6, 10];
        break;
    elseif i == 17
        eliminatedNodes = [6, 11];
        break;
    elseif i == 18
        eliminatedNodes = [7, 8];
        break;
    elseif i == 19
        eliminatedNodes = [7, 11];
        break;
    elseif i == 20
        eliminatedNodes = [7, 12];
        break;
    elseif i == 21
        eliminatedNodes = [8, 12];
        break;
    elseif i == 22
        eliminatedNodes = [8, 13];
        break;
    elseif i == 23
        eliminatedNodes = [9, 10];
        break;
    elseif i == 24
        eliminatedNodes = [9, 14];
        break;
    elseif i == 25
        eliminatedNodes = [10, 11];
        break;
    elseif i == 26
        eliminatedNodes = [10, 14];
        break;
    elseif i == 27
        eliminatedNodes = [10, 15];
        break;
    elseif i == 28
        eliminatedNodes = [11, 12];
        break;
    elseif i == 29
        eliminatedNodes = [11, 15];
        break;
    elseif i == 30
        eliminatedNodes = [11, 16];
        break;
    elseif i == 31
        eliminatedNodes = [12, 13];
        break;
    elseif i == 32
        eliminatedNodes = [12, 16];
        break;
    elseif i == 33
        eliminatedNodes = [12, 17];
        break;
    elseif i == 34
        eliminatedNodes = [13, 17];
        break;
    elseif i == 35
        eliminatedNodes = [14, 15];
        break;
    elseif i == 36
        eliminatedNodes = [14, 18];
        break;
    elseif i == 37
        eliminatedNodes = [15, 16];
        break;
    elseif i == 38
        eliminatedNodes = [15, 18];
        break;
    elseif i == 39
        eliminatedNodes = [15, 19];
        break;
    elseif i == 40
        eliminatedNodes = [16, 17];
        break;
    elseif i == 41
        eliminatedNodes = [16, 19];
        break;
    elseif i == 42
        eliminatedNodes = [16, 20];
        break;
    elseif i == 43
        eliminatedNodes = [17, 20];
        break;
    elseif i == 44
        eliminatedNodes = [18, 19];
        break;
    elseif i == 45
        eliminatedNodes = [18, 21];
        break;
    elseif i == 46
        eliminatedNodes = [19, 20];
        break;
    elseif i == 47
        eliminatedNodes = [19, 21];
        break;
    elseif i == 48
        eliminatedNodes = [20, 21];
        break;
    end
end
end
