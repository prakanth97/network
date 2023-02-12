public function getAllThePaths(Graph g, Vertex u, Vertex v) returns string[][] {
    string vertexU = u.toString();
    string vertexV = v.toString();
    map<boolean> isVisited = {};
    string[][] allPathList = [];
    string[] pathList = [];

    pathList.push(vertexU);
    getAllThePathUntil(g, vertexU, vertexV, isVisited, pathList, allPathList);
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

    string[] successors = [];
    string[]|error successorsOfNode = graph.successor('source);
    if successorsOfNode is string[] {
        successors = successorsOfNode;
    }

    foreach string item in successors {
        if !(isVisited[item] is true) {
            localPathList.push(item);
            getAllThePathUntil(graph, item, destination, isVisited, localPathList, allPathList);

            // remove the current node
            int indexOfItem = <int>localPathList.indexOf(item);
            _ = localPathList.remove(indexOfItem);
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
