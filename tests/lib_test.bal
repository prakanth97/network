import ballerina/test;

Graph graph1 = new DiGraph();
Graph graph2 = new UnDiGraph();

// Before Suite Function

@test:BeforeSuite
function beforeSuiteFunc() {
    graph1.addEdge(1, 2, 2);
    graph1.addEdge(2, 3, 2);
    graph1.addEdge(3, 4, 2);
    graph1.addEdge(1, 5, 4);
    graph1.addEdge(5, 4, 2);
    graph1.addEdge(1, 6, 1);
    graph1.addEdge(6, 7, 0);
    graph1.addEdge(7, 8, 1);
    graph1.addEdge(8, 5, 1);
    graph1.addEdge(8, 9, 1);
    graph1.addEdge(9, 4, 6);

    graph2.addEdge(1, 2, 2);
    graph2.addEdge(3, 2, 2);
    graph2.addEdge(3, 4, 2);
    graph2.addEdge(5, 1, 1);
    graph2.addEdge(5, 4, 2);
    graph2.addNode(6);
}

// Test function

@test:Config {}
function testShortestPath() {
    test:assertEquals(shortestPath(graph1, 1, 4, true), ["1", "6", "7", "8", "5", "4"]);
    test:assertEquals(shortestPath(graph1, 1, 4, false), ["1", "5", "4"]);

    test:assertEquals(shortestPath(graph2, 1, 4, true), ["1", "5", "4"]);
    test:assertEquals(shortestPath(graph2, 1, 4), ["1", "5", "4"]);
}

@test:Config {}
function testIsPathExists() {
    test:assertEquals(isPathExists(graph1, 6, 5), true);
    test:assertEquals(isPathExists(graph1, 7, 4), true);

    test:assertEquals(isPathExists(graph2, 1, 4), true);
    test:assertEquals(isPathExists(graph2, 2, 5), true);
}

@test:Config {}
function testIsPathExistsNegative() {
    test:assertEquals(isPathExists(graph1, 2, 5), false);
    test:assertEquals(isPathExists(graph1, 9, 1), false);

    test:assertEquals(isPathExists(graph2, 1, 6), false);
    test:assertEquals(isPathExists(graph2, 6, 5), false);
}

@test:Config {}
function testLongestPath() {
    test:assertEquals(longestPath(graph1, 1, 4), ["1", "6", "7", "8", "5", "4"]);
    test:assertEquals(longestPath(graph1, 1, 5), ["1", "6", "7", "8", "5"]);

    test:assertEquals(longestPath(graph2, 1, 4), ["1", "2", "3", "4"]);
    test:assertEquals(longestPath(graph2, 5, 2), ["5", "4", "3", "2"]);
}

// After Suite Function

@test:AfterSuite
function afterSuiteFunc() {
    graph1.clear();
    graph2.clear();
}
