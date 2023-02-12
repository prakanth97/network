public type Vertex int|string;

public type GraphTb table<Node> key(vertex);

public type Node record {|
    readonly string vertex;
    map<int> edges = {};
|};

public type Queue record {|
    string vertex;
    string[] path;
|}[];

public type Graph object {
    public function getGraphTable() returns GraphTb;

    public function addNode(Vertex v);

    public function removeNode(Vertex v) returns Node?;

    public function numberOfNodes() returns int;

    public function 'order() returns int;

    public function hasNode(Vertex v) returns boolean;

    public function addEdge(Vertex u, Vertex v, int weight = 0);

    public function removeEdge(Vertex u, Vertex v) returns boolean;

    public function hasEdge(Vertex u, Vertex v) returns boolean;

    public function getEdgeWeight(Vertex u, Vertex v) returns int|error;

    public function clear();

    public function clearEdges();

    public function isDirectedGraph() returns boolean;

    public function copy() returns Graph;

    public function size(boolean weight = false) returns int;

    public function numberOfEdges(Vertex? u = null, Vertex? v = null) returns int;

    public function successor(Vertex u) returns string[]|error;
};
