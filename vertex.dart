class Graph {
  final List<List<int>> adjMatrix;

  Graph(this.adjMatrix);

  // Function to calculate the total distance for a given route
  int calculateTotalDistance(List<int> route) {
    int totalDistance = 0;
    for (int i = 0; i < route.length - 1; i++) {
      totalDistance += adjMatrix[route[i]][route[i + 1]];
    }
    return totalDistance;
  }

  // Brute Force TSP algorithm to find the shortest path
  void tsp(int start) {
    List<int> vertices = [];
    for (int i = 0; i < adjMatrix.length; i++) {
      if (i != start) vertices.add(i);
    }

    List<int> shortestRoute = [];
    int minDistance = 999999; // A large number to initialize min distance

    // Generate all permutations of vertices except the start point
    permute(vertices, 0, vertices.length - 1, (List<int> permutedRoute) {
      List<int> fullRoute = [start] + permutedRoute + [start];
      int distance = calculateTotalDistance(fullRoute);
      if (distance < minDistance) {
        minDistance = distance;
        shortestRoute = fullRoute;
      }
    });

    // Print the optimized route and total distance
    print('Optimized Route: ${shortestRoute.map((v) => String.fromCharCode(97 + v)).toList()}');
    print('Total distance: $minDistance');
  }

  // Helper function to generate permutations
  void permute(List<int> list, int left, int right, void Function(List<int>) callback) {
    if (left == right) {
      callback(List<int>.from(list)); // Create a copy of the list and call the callback
    } else {
      for (int i = left; i <= right; i++) {
        _swap(list, left, i);
        permute(list, left + 1, right, callback);
        _swap(list, left, i); // Backtrack
      }
    }
  }

  // Helper function to swap two elements in a list
  void _swap(List<int> list, int i, int j) {
    int temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
}

void main() {
  // Example adjacency matrix representing distances between points a, b, c, d, e
  List<List<int>> adjMatrix = [
    [0, 8, 3, 4, 10],  // a
    [8, 0, 5, 2, 7],   // b
    [3, 5, 0, 1, 6],   // c
    [4, 2, 1, 0, 3],   // d
    [10, 7, 6, 3, 0]   // e
  ];

  int startPoint = 0;  // Starting from point a (index 0)
  Graph graph = Graph(adjMatrix);
  graph.tsp(startPoint);  // Find the shortest path
}
