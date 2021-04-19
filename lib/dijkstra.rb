# Time Complexity: O(v^2) - Since we are performing a variety of BFS on an adjacency matrix,
# the time complexity to search all edges will be, at worst case, O(v^2), assuming all vertices v
# are interconnected. This is because for each node visited, the entire associated row on the 
# adjacency matrix has to be checked to confirm which edges are actual graph edges. 

# Space Complexity: O(v) - A couple arrays are create, size directly equal to the number of vertices v. 
# Likewise, the Queue and Set created to track nodes to visit and visited nodes are also directly
# equal to tne number of vertices in the graph. The return hash is simply a wrapper that envelops
# the shortest_distances and parent_list arrays. 
def dijkstra(adjacency_matrix, start_node) 
    shortest_distances = Array.new(adjacency_matrix[0].length){Float::INFINITY}
    parent_list = Array.new(shortest_distances.length){nil} 
    tracking_q = Queue.new
    visited_nodes = Set.new

    # start with start node
    # start node has no previous node, marked as 0
    visited_nodes.add(start_node)
    shortest_distances[start_node] = 0

    adjacency_matrix[start_node].each_with_index do |weight, i|
        if weight > 0 && i != start_node
            parent_list[i] = start_node
            shortest_distances[i] = weight
            tracking_q.push(i)
        end
    end

    until (tracking_q.empty?) 
        cur_node = tracking_q.pop
        # skip already visited nodes
        next if visited_nodes.include?(cur_node)
        # check all adjacent nodes
        visited_nodes.add(cur_node)

        # check for adjacent nodes
        adjacency_matrix[cur_node].each_with_index do |weight, i|
            # ignore those with no weight
            if weight > 0 && i != cur_node
                if shortest_distances[cur_node] + weight < shortest_distances[i]
                    shortest_distances[i] = shortest_distances[cur_node] + weight
                    parent_list[i] = cur_node
                end
                tracking_q.push(i)
            end
        end
    end

    return {start_node: start_node, 
            parent_list: parent_list, 
            shortest_distances: shortest_distances}
end
