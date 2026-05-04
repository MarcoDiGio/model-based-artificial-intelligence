#include "RomaniaProblem.h"

RomaniaProblem::RomaniaProblem()
    : m_map{
        {"Arad",         { {"Zerind", 75}, {"Sibiu", 140}, {"Timisoara", 118} }},
        {"Bucharest",    { {"Fagaras", 211}, {"Pitesti", 101}, {"Giurgiu", 90}, {"Urziceni", 85} }},
        {"Craiova",      { {"Dobreta", 120}, {"Rimnicu Vilcea", 146}, {"Pitesti", 138} }},
        {"Dobreta",      { {"Mehadia", 75}, {"Craiova", 120} }},
        {"Eforie",       { {"Hirsova", 86} }},
        {"Fagaras",      { {"Sibiu", 99}, {"Bucharest", 211} }},
        {"Giurgiu",      { {"Bucharest", 90} }},
        {"Hirsova",      { {"Urziceni", 98}, {"Eforie", 86} }},
        {"Iasi",         { {"Vaslui", 92}, {"Neamt", 87} }},
        {"Lugoj",        { {"Timisoara", 111}, {"Mehadia", 70} }},
        {"Mehadia",      { {"Lugoj", 70}, {"Dobreta", 75} }},
        {"Neamt",        { {"Iasi", 87} }},
        {"Oradea",       { {"Zerind", 71}, {"Sibiu", 151} }},
        {"Pitesti",      { {"Rimnicu Vilcea", 97}, {"Craiova", 138}, {"Bucharest", 101} }},
        {"Rimnicu Vilcea",{ {"Sibiu", 80}, {"Craiova", 146}, {"Pitesti", 97} }},
        {"Sibiu",        { {"Arad", 140}, {"Oradea", 151}, {"Fagaras", 99}, {"Rimnicu Vilcea", 80} }},
        {"Timisoara",    { {"Arad", 118}, {"Lugoj", 111} }},
        {"Urziceni",     { {"Bucharest", 85}, {"Vaslui", 142}, {"Hirsova", 98} }},
        {"Vaslui",       { {"Urziceni", 142}, {"Iasi", 92} }},
        {"Zerind",       { {"Arad", 75}, {"Oradea", 71} }}
    }
{}

const State RomaniaProblem::initial_state() const {
    return State{"Arad"};
}

bool RomaniaProblem::is_goal(const State& state) const {
    return state.getName() == "Bucharest";
}

std::vector<std::unique_ptr<Action>> RomaniaProblem::actions(const State& state) const 
{
    std::vector<std::unique_ptr<Action>> available_actions;

    auto it = m_map.find(state.getName());
    if (it != m_map.end()) {
        for (const auto& romania_action : it->second) {
            available_actions.push_back(
                std::make_unique<RomaniaAction>(romania_action)
            );
        }
    }
    return available_actions;
}

State RomaniaProblem::result([[maybe_unused]] const State& state, const Action& action) const {
    const auto& ro_action = dynamic_cast<const RomaniaAction&>(action);
    return State{ro_action.getDestination()};
}

double RomaniaProblem::heuristic(const State& state) const {
    static const std::unordered_map<std::string, double> sld = {
        {"Arad", 366}, {"Bucharest", 0}, {"Craiova", 160},
        {"Dobreta", 242}, {"Eforie", 161}, {"Fagaras", 178},
        {"Giurgiu", 77}, {"Hirsova", 151}, {"Iasi", 226},
        {"Lugoj", 244}, {"Mehadia", 241}, {"Neamt", 234},
        {"Oradea", 380}, {"Pitesti", 98}, {"Rimnicu Vilcea", 193},
        {"Sibiu", 253}, {"Timisoara", 329}, {"Urziceni", 80},
        {"Vaslui", 199}, {"Zerind", 374}
    };

    auto it = sld.find(state.getName());
    if (it != sld.end()) return it->second;
    return 0.0;
}