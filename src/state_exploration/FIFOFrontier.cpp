#include "FIFOFrontier.h"
#include <algorithm>

FIFOFrontier::FIFOFrontier()
    : m_nodes{}
{}

void FIFOFrontier::push(std::shared_ptr<Node> node) {
    m_nodes.push_back(std::move(node));
}

std::shared_ptr<Node> FIFOFrontier::pop() {
    auto front = std::move(m_nodes.front());
    m_nodes.pop_front();
    return front;
}

bool FIFOFrontier::empty() const {
    return m_nodes.empty();
}

size_t FIFOFrontier::size() const {
    return m_nodes.size();
}

std::shared_ptr<Node> FIFOFrontier::contains(const State& s) const {
    auto found = std::find_if(m_nodes.begin(), m_nodes.end(), [&](const std::shared_ptr<Node>& node) {
        return node->state() == s;
    });
    if(found != m_nodes.end()) 
        return *found;
    return nullptr;
}

void FIFOFrontier::remove(const State& s) {
    m_nodes.erase(
        std::remove_if(m_nodes.begin(), m_nodes.end(), [&](const std::shared_ptr<Node>& node) {
            return node->state() == s;
        }),
        m_nodes.end()
    );
}