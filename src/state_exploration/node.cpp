#include "node.h"

Node::Node(State initial_state, int heuristic)
    : m_state(std::move(initial_state)), m_g(0), m_h(heuristic), 
      m_parent(nullptr), m_action(nullptr) 
{}

Node::Node(State state, int g, int h, std::shared_ptr<Node> parent, std::unique_ptr<Action> action)
    : m_state(std::move(state)), m_g(g), m_h(h), 
      m_parent(std::move(parent)), m_action(std::move(action)) 
{}