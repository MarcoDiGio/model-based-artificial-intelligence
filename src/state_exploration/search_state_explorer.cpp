#include <unordered_set>
#include "search_state_explorer.h"

namespace Search{
    std::shared_ptr<Node> graph_search(const Problem& problem, Frontier& frontier, bool use_heuristics) {

        double initial_h { 0.0 };
        if(use_heuristics)
        {
            initial_h = problem.heuristic(problem.initial_state());
        }
        frontier.push(std::make_shared<Node>(problem.initial_state(), initial_h));
        std::unordered_set<State> explored;

        while (!frontier.empty()) 
        {
            auto node = frontier.pop();

            // if state is goal, solution found!
            if (problem.is_goal(node->state())) 
            {
                return node;
            }

            explored.insert(node->state());

            auto available_actions = problem.actions(node->state());
            
            // for every available action from the current node
            for (auto& action_ptr : available_actions) 
            {
                State child_state = problem.result(node->state(), *action_ptr);
                
                bool is_explored = explored.find(child_state) != explored.end();

                double h {0.0};

                if (use_heuristics)
                {
                    h = problem.heuristic(child_state);
                }
                
                double step_cost = dynamic_cast<Action*>(action_ptr.get())->getCost();
                auto child_node = std::make_shared<Node>(
                    child_state,
                    node->g() + step_cost, 
                    h,                     
                    node,                  
                    std::move(action_ptr)
                );

                if (!is_explored) 
                {
                    auto frontier_child = frontier.contains(child_state);
                    
                    if(!frontier_child) 
                    {
                        frontier.push(child_node);
                    } else 
                    {
                        if (frontier_child.get()->g() > child_node.get()->g())
                        {
                            frontier.remove(child_state);
                            frontier.push(child_node);
                        }
                    }
                }
            }
        }
        return nullptr;
    }
}