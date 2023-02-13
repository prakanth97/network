import ballerina/test;

// Before Suite Function

@test:BeforeSuite
function beforeSuiteFunc() {
}

// Test function

@test:Config {}
function testShortestPath() {
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

    test:assertEquals(shortestPath(graph, 1, 4, true), ["1", "6", "7", "8", "5", "4"]);
    test:assertEquals(shortestPath(graph, 1, 4, false), ["1", "5", "4"]);

    Graph graph1 = new UnDiGraph();
    graph1.addEdge(1, 2, 2);
    graph1.addEdge(3, 2, 2);
    graph1.addEdge(3, 4, 2);
    graph1.addEdge(5, 1, 1);
    graph1.addEdge(5, 4, 2);

    // considering the weight
    test:assertEquals(shortestPath(graph1, 1, 4, true), ["1", "5", "4"]);
    test:assertEquals(shortestPath(graph1, 1, 4), ["1", "5", "4"]);
}

// Negative Test function

@test:Config {}
function negativeTestFunction() {
    // string name = "";
    // string welcomeMsg = hello(name);
    // test:assertEquals("Hello, World!", welcomeMsg);
}

// After Suite Function

@test:AfterSuite
function afterSuiteFunc() {
}
