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

public function getLongestPath(Graph graph, Vertex 'source, Vertex destination) returns string[] {
    string[][] allThePaths = getAllThePaths(graph, 'source, destination);

    string[] longestPath = [];
    foreach string[] path in allThePaths {
        if path.length() > longestPath.length() {
            longestPath = path;
        }
    }
    return longestPath;
}
