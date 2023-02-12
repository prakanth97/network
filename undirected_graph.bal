public class UnDiGraph {
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

    public function addEdge(Vertex u, Vertex v, int weight = 0) {
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

        Node n2 = self.graphtb.get(vertexV);
        n2.edges[vertexU] = weight;
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
        Node n2 = self.graphtb.get(vertexV);
        return n1.edges.removeIfHasKey(vertexV) !is () && n2.edges.removeIfHasKey(vertexU) !is ();
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
        return false;
    }

    public function copy() returns UnDiGraph {
        UnDiGraph g = new ();
        GraphTb graphtb = g.getGraphTable();
        foreach Node node in self.graphtb {
            Node cloneNode = node.clone();
            graphtb.add(cloneNode);
        }
        return g;
    }

    public function size(boolean weight = false) returns int {
        int edgeCountOrWeight = 0;
        string[] visitedNode = [];

        if weight {
            foreach Node node in self.graphtb {
                visitedNode.push(node.vertex);
                foreach string edge in node.edges.keys() {
                    if visitedNode.indexOf(edge) is int {
                        continue;
                    }
                    edgeCountOrWeight += node.edges.get(edge);
                }
            }
        } else {
            foreach Node node in self.graphtb {
                visitedNode.push(node.vertex);
                foreach string edge in node.edges.keys() {
                    if visitedNode.indexOf(edge) is int {
                        continue;
                    }
                    edgeCountOrWeight += 1;
                }
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

    public function toDirectedGraph() {

    }
}
