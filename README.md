# Network

The `network` library created for Ballerina offers a range of capabilities for representing and manipulating graph structures within the Ballerina environment. With this library, users can create a graph, add vertices and edges, search for paths between vertices, determine the shortest distance between two vertices, and perform other related operations.

## Simple example

```
import ballerina/io;

public function main() {
    Graph graph = new DiGraph();
    graph.addEdge(1, 2, 2);
    graph.addEdge(2, 3, 2);
    graph.addEdge(3, 4, 2);
    graph.addEdge(1, 5, 4);
    graph.addEdge(5, 4, 2);
    graph.addEdge(1, 6, 1);
    graph.addEdge(6, 7, 0);
    graph.addEdge(7, 8, 1);
    graph.addEdge(8, 5, 1);
    graph.addEdge(8, 9, 1);
    graph.addEdge(9, 4, 6);

    // considering the weight
    io:println(shortestPath(graph, "1", "4", true));

    // without considering the weight
    io:println(shortestPath(graph, "1", "4"));
}
```
