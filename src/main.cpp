#include <algorithm>
#include <iostream>
#include <unordered_set>
#include "state_exploration/search_state_explorer.h"
#include "state_exploration/FIFOFrontier.h"
#include "state_exploration/LIFOFrontier.h"
#include "state_exploration/PriorityFrontier.h"
#include "state_exploration/examples/RomaniaProblem.h"

void printSolutionPath(std::shared_ptr<Node> solution) {
    if (!solution) return;

    std::vector<std::string> path;
    std::shared_ptr<Node> current = solution;

    while (current != nullptr) {
        path.push_back(current->state().getName());
        current = current->parent();
    }

    std::reverse(path.begin(), path.end());

    std::cout << "Path:\n";
    for (size_t i = 0; i < path.size(); ++i) {
        std::cout << path[i];
        if (i < path.size() - 1) std::cout << " -> ";
    }
    std::cout << std::endl;
}

int main() {
    RomaniaProblem problem;
    // FIFOFrontier bfs;
    PriorityFrontier min_cost;
    PriorityFrontier A_STAR;
    
    auto solution = Search::graph_search(problem, min_cost);
    
    if (solution) {
        std::cout << "Found path for Bucharest with total cost: " << solution->g() << "\n";
        printSolutionPath(solution);
    } else {
        std::cout << "Path not found.\n";
    }

    auto solution2 = Search::graph_search(problem, A_STAR, true);
    if (solution2) {
        std::cout << "Found path for Bucharest with total cost: " << solution2->g() << "\n";
        printSolutionPath(solution2);
    } else {
        std::cout << "Path not found.\n";
    }
    return 0;
}