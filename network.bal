public function shortestPath(Graph graph, Vertex 'source, Vertex destination, boolean weight = false) returns string[]|error {
    string sourceV = 'source.toString();
    string destinationV = destination.toString();

    if weight {
        return dijikstraShortestPath(graph, sourceV, destinationV);
    }

    return bfsShortestPath(graph, sourceV, destinationV);
}

public function bfsShortestPath(Graph graph, string 'source, string destination) returns string[]|error {
    if 'source == destination {
        return ['source];
    }

    Queue queue = [{vertex: 'source, path: ['source]}];
    map<boolean> isVisited = {};
    while queue.length() != 0 {
        var {vertex, path} = queue.remove(0);
        foreach string successor in check graph.successor(vertex) {
            if successor == destination {
                path.push(successor);
                return path;
            }

            if !isVisited.hasKey(successor) {
                isVisited[successor] = true;
                string[] newPath = path.clone();
                newPath.push(successor);
                queue.push({
                    vertex: successor,
                    path: newPath
                });
            }
        }
    }
    return [];
}

public function dijikstraShortestPath(Graph graph, string 'source, string destination) returns string[]|error {
    string[] nodes = graph.getNodes();

    map<int> distances = map from string vertex in nodes
        select [vertex, int:MAX_VALUE];
    distances['source] = 0;

    map<string?> previous = map from string vertex in nodes
        select [vertex, null];

    [int, string][] stack = [[0, 'source]];

    while stack.length() != 0 {
        stack = from [int, string] [dist, vertex] in stack
            order by dist descending
            select [dist, vertex];
        [int, string] [dist, current] = stack.pop();
        if current == destination {
            break;
        }
        foreach [string, int] [neighbour, weight] in (check graph.neighbours(current)).entries() {
            int distance = dist + weight;
            if distance < distances[neighbour] {
                distances[neighbour] = distance;
                previous[neighbour] = current;
                stack.push([distance, neighbour]);
            }
        }
    }

    string? current = destination;
    string[] path = [];

    while current != null {
        path.push(current);
        current = previous[current];
    }

    return path.reverse();
}

public function isPathExists(Graph graph, Vertex 'source, Vertex destination) returns boolean {
    string sourceV = 'source.toString();
    string destinationV = destination.toString();
    map<boolean> isVisited = {};
    return depthFistSearch(graph, sourceV, destinationV, isVisited) is null ? false : true;
}

function depthFistSearch(Graph graph, string 'source, string destination,
        map<boolean> isVisited) returns boolean? {

    if 'source == destination {
        return true;
    }
    isVisited['source] = true;

    string[]|error successors = graph.successor('source);
    if successors is string[] {
        foreach string successor in successors {
            if !(isVisited[successor] is true) {
                if depthFistSearch(graph, successor, destination, isVisited) !is null {
                    return true;
                }
            }
        }
    }

    isVisited['source] = false;
    return;
}

public function getAllThePaths(Graph graph, Vertex 'source, Vertex destination) returns string[][] {
    string 'sourceV = 'source.toString();
    string destinationV = destination.toString();
    map<boolean> isVisited = {};
    string[][] allPathList = [];
    string[] pathList = [];

    pathList.push('sourceV);
    getAllThePathUntil(graph, 'sourceV, destinationV, isVisited, pathList, allPathList);
    return allPathList;
}

function getAllThePathUntil(Graph graph, string 'source, string destination,
        map<boolean> isVisited, string[] localPathList, string[][] allPathList) {
    if 'source == destination {
        allPathList.push(localPathList.clone());
        return;
    }

    // Mark the current node
    isVisited['source] = true;

    string[]|error successors = graph.successor('source);
    if successors is string[] {
        foreach string item in successors {
            if !(isVisited[item] is true) {
                localPathList.push(item);
                getAllThePathUntil(graph, item, destination, isVisited, localPathList, allPathList);

                // remove the current node
                int indexOfItem = <int>localPathList.indexOf(item);
                _ = localPathList.remove(indexOfItem);
            }
        }
    }

    // Mark the current node
    isVisited['source] = false;
}

public function longestPath(Graph graph, Vertex 'source, Vertex destination) returns string[] {
    string[][] allThePaths = getAllThePaths(graph, 'source, destination);

    string[] longestPath = [];
    foreach string[] path in allThePaths {
        if path.length() > longestPath.length() {
            longestPath = path;
        }
    }
    return longestPath;
}

// TODO: 
// Bellman-Ford Algorithm to handle negative weight and cycles,
// A* algorithm to optimize shortest path algorithm with positive weight, 
// shortest distance from single source to all vetices.
