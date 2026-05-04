#include "LIFOFrontier.h"
#include <algorithm>

LIFOFrontier::LIFOFrontier() 
    : m_nodes{} 
{}

void LIFOFrontier::push(std::shared_ptr<Node> node) {
    m_nodes.push_back(std::move(node));
}

std::shared_ptr<Node> LIFOFrontier::pop() {
    auto top = std::move(m_nodes.back());
    m_nodes.pop_back();
    return top;
}

bool LIFOFrontier::empty() const {
    return m_nodes.empty();
}

size_t LIFOFrontier::size() const {
    return m_nodes.size();
}

std::shared_ptr<Node> LIFOFrontier::contains(const State& s) const {
    auto found = std::find_if(m_nodes.begin(), m_nodes.end(), [&](const std::shared_ptr<Node>& node) {
        return node->state() == s;
    });
    if(found != m_nodes.end()) 
        return *found;
    return nullptr;
}

void LIFOFrontier::remove(const State& s) {
    m_nodes.erase(
        std::remove_if(m_nodes.begin(), m_nodes.end(), [&](const auto& node) {
            return node->state() == s;
        }), 
        m_nodes.end()
    );
}