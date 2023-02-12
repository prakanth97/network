public class DiGraph {
    *Graph;

    private GraphTb graphtb = table [];

    public function getGraphTable() returns GraphTb {
        return self.graphtb;
    }

    // TODO: add two graphs, add multiple vertices.
    public function addNode(Vertex v) {
        string node = v.toString();
        if !self.graphtb.hasKey(node) {
            self.graphtb.add({vertex: node});
        }
    }

    public function removeNode(Vertex v) returns Node? {
        string node = v.toString();
        if self.graphtb.hasKey(node) {
            Node n = self.graphtb.remove(node);
            foreach string edge in n.edges.keys() {
                Node edgeNode = self.graphtb.get(edge);
                _ = edgeNode.edges.remove(node);
            }
            return n;
        }
        return;
    }

    public function numberOfNodes() returns int {
        return self.graphtb.length();
    }

    public function 'order() returns int {
        return self.graphtb.length();
    }

    public function hasNode(Vertex v) returns boolean {
        return self.graphtb.hasKey(v.toString());
    }

    public function getNodes() returns string[] {
        return self.graphtb.keys();
    }

    public function addEdge(Vertex u, Vertex v, int weight = 1) {
        string vertexU = u.toString();
        string vertexV = v.toString();

        if !self.graphtb.hasKey(vertexU) {
            self.addNode(u);
        }

        if !self.graphtb.hasKey(vertexV) {
            self.addNode(v);
        }

        Node n1 = self.graphtb.get(vertexU);
        n1.edges[vertexV] = weight;
    }

    public function removeEdge(Vertex u, Vertex v) returns boolean {
        string vertexU = u.toString();
        string vertexV = v.toString();

        if !self.graphtb.hasKey(vertexU) {
            return false;
        }

        if !self.graphtb.hasKey(vertexV) {
            return false;
        }

        Node n1 = self.graphtb.get(vertexU);
        return n1.edges.removeIfHasKey(vertexV) !is ();
    }

    public function hasEdge(Vertex u, Vertex v) returns boolean {
        string vertexU = u.toString();
        string vertexV = v.toString();

        if self.graphtb.hasKey(vertexU) {
            return self.graphtb.get(vertexU).edges.hasKey(vertexV);
        }
        return false;
    }

    public function getEdgeWeight(Vertex u, Vertex v) returns int|error {
        string vertexU = u.toString();
        string vertexV = v.toString();

        if self.graphtb.hasKey(vertexU) {
            int? weight = self.graphtb.get(vertexU).edges[vertexV];
            if weight is int {
                return weight;
            }
            return error(string `${vertexU} doesn't have edge ${vertexV}`);
        }
        return error(string `${vertexU} is not exist`);
    }

    public function clear() {
        self.graphtb.removeAll();
    }

    public function clearEdges() {
        foreach Node node in self.graphtb {
            node.edges.removeAll();
        }
    }

    public function isDirectedGraph() returns boolean {
        return true;
    }

    public function copy() returns DiGraph {
        DiGraph g = new ();
        GraphTb graphtb = g.getGraphTable();
        foreach Node node in self.graphtb {
            Node cloneNode = node.clone();
            graphtb.add(cloneNode);
        }
        return g;
    }

    public function size(boolean weight = false) returns int {
        int edgeCountOrWeight = 0;

        if weight {
            foreach Node node in self.graphtb {
                edgeCountOrWeight += node.edges.reduce(
                    function(int total, int value) returns int {
                    return total + value;
                }, 0);
            }
        } else {
            foreach Node node in self.graphtb {
                edgeCountOrWeight += node.edges.length();
            }
        }
        return edgeCountOrWeight;
    }

    public function numberOfEdges(Vertex? u = null, Vertex? v = null) returns int {
        if u is () && v is () {
            return self.size();
        }

        if u is () || v is () {
            return 0;
        }
        return self.hasEdge(u, v) ? 1 : 0;
    }

    public function successor(Vertex u) returns string[]|error {
        string vertexU = u.toString();

        if !self.graphtb.hasKey(vertexU) {
            return error(string `${vertexU} not found`);
        }

        return self.graphtb.get(vertexU).edges.keys();
    }

    public function neighbours(Vertex u) returns map<int>|error {
        string vertexU = u.toString();

        if !self.graphtb.hasKey(vertexU) {
            return error(string `${vertexU} not found`);
        }

        return self.graphtb.get(vertexU).edges;
    }

    public function predecessor(Vertex u) returns string[]|error {
        string vertexU = u.toString();
        string[] predecessors = [];

        if !self.graphtb.hasKey(vertexU) {
            return error(string `${vertexU} not found`);
        }

        foreach Node node in self.graphtb {
            if node.edges.hasKey(vertexU) {
                predecessors.push(node.vertex);
            }
        }
        return predecessors;
    }

    public function inDegree(Vertex u) returns int|error {
        string vertexU = u.toString();
        if !self.graphtb.hasKey(vertexU) {
            return error(string `${vertexU} not found`);
        }

        int count = 0;
        foreach Node node in self.graphtb {
            if node.edges.hasKey(vertexU) {
                count += 1;
            }
        }
        return count;
    }

    public function outDegree(Vertex u) returns int|error {
        string vertexU = u.toString();
        if !self.graphtb.hasKey(vertexU) {
            return error(string `${vertexU} not found`);
        }

        return self.graphtb.get(vertexU).edges.length();
    }
}
