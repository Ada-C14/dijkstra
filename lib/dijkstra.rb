# Homework: convert adj matrix code to the method handling adjacency list as an input data structure. 
# Each entry in the adjacency list will need to store a weight as well as the destination node.
# --> using method "matrix_to_list_helper" to take care of this

# time complexity (ignore the conversion from adj matrix to adj list): O(v+e), v is the number of vertices and e is the number of edges.
#                  It visits every vertex and its edges. 
# space complexity (ignore adj_list): O(v): v is the number of vertices, 
#                  because the variables parent_list, shortest_distances, marked would be changed based on the number of vertices.
#                  Also, the worst case scenario for queue is to temporary store the number of vertices.
#                  Overall, it would be O(v*4) --> O(v).
def dijkstra(adjacency_matrix, start_node) 
  # convert adjacency matrix to adjacency list (NOT min heap)
  adj_list = matrix_to_list_helper(adjacency_matrix)

  # parent_list starts with nil to handle the unconnected graph
  parent_list = Array.new(adj_list.length, nil)
  # shortest_distances starts with infinity as the value
  shortest_distances = Array.new(adj_list.length, Float::INFINITY)
  # marked will save the visited vertax
  marked = {}

  # start_node is 0 distance from itself and its parent is nil
  shortest_distances[start_node] = 0
  parent_list[start_node] = nil

  # track the path by using queue, BFS
  queue = [start_node]
  while !queue.empty?
    parent = queue.pop
    marked[parent] = true

    adj_list[parent].each do |neighbor, weight|
      if !marked[neighbor]
        queue.push(neighbor)
      end

      current_distance = shortest_distances[neighbor]
      # update distance for the neighbor
      shortest_distances[neighbor] = [shortest_distances[neighbor], weight + shortest_distances[parent]].min
      if current_distance != shortest_distances[neighbor]
        parent_list[neighbor] = parent
      end
    end
  end

  return {start_node: start_node, parent_list: parent_list, shortest_distances: shortest_distances }
end

# convert the matrix from tests to adjacency list
def matrix_to_list_helper(adjacency_matrix)
  adj_list = Array.new(adjacency_matrix.length) {Hash.new()}

  adjacency_matrix.each_with_index do |edges, vertex|
    edges.each_with_index do |weight, neighbor|
      if weight != 0
        adj_list[vertex][neighbor] = weight
      end
    end
  end
  return adj_list  
end




### Original code for handling adjacency matrix
# def dijkstra(adjacency_matrix, start_node) 

#   #int nVertices = adjacencyMatrix[0].length; 
#   num_nodes = adjacency_matrix.length

#   # shortest_distances will hold the shortest distances from start_node to i
#   # it starts with infinity as the value
#   shortest_distances = Array.new(num_nodes, Float::INFINITY)


#   # added[i] will be true if the path to i 
#   # from the source has been found
#   added = Array.new(num_nodes, false)


#   # Distance of source vertex from 
#   # itself is always 0
#   shortest_distances[start_node] = 0
  
#   # parent array to store the shortest path tree 
#   parents = Array.new(num_nodes)
#   # no parent for the start node
#   parents[start_node] = nil 


#   # Find shortest path for all nodes 
#   (num_nodes - 1).times do

#     # Pick the minimum distance vertex 
#     # from the set of vertices not yet 
#     # processed. nearest_node is  
#     # always equal to start_node in  
#     # first iteration. 
#     nearest_node = -1
#     shortest_distance = Float::INFINITY
#     (0...num_nodes).each do |node_index|
#       if (!added[node_index] && 
#           shortest_distances[node_index] <  shortest_distance)  
#         nearest_node  = node_index
#         shortest_distance = shortest_distances[node_index]
#       end
#     end  

#     # Mark the picked vertex as visited
#     added[nearest_node] = true; 
#     # Update dist value of the 
#     # adjacent nodes of the picked node. 
#     (0...num_nodes).each do |node_index|
#       edge_distance = adjacency_matrix[nearest_node][node_index]; 

#       if (edge_distance > 0 && 
#           ((shortest_distance + edge_distance) <  
#               shortest_distances[node_index]))  
#         parents[node_index] = nearest_node; 
#         shortest_distances[node_index] = shortest_distance +  
#                                         edge_distance 
#       end
#     end
#   end
#   return {start_node: start_node, parent_list: parents, shortest_distances: shortest_distances }
# end
