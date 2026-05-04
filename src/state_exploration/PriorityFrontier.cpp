#include <algorithm>
#include "PriorityFrontier.h"

PriorityFrontier::PriorityFrontier(PriorityFrontier::Order order) 
    : m_nodes{},
      m_order{order}
    {}

bool PriorityFrontier::compare(const std::shared_ptr<Node>& a, const std::shared_ptr<Node>& b) const {
    if (m_order == PriorityFrontier::Order::MIN)
    {
        return a.get()->f() > b.get()->f();
    } else {
        return a.get()->f() <= b.get()->f();
    }
}

void PriorityFrontier::push(std::shared_ptr<Node> node) {
    m_nodes.push_back(std::move(node));
    std::push_heap(
        m_nodes.begin(),
        m_nodes.end(), 
        [this](auto& a, auto& b) { return compare(a, b); }
    );
}

std::shared_ptr<Node> PriorityFrontier::pop() {
    if(empty()) return nullptr;

    std::pop_heap(
        m_nodes.begin(),
        m_nodes.end(),
        [this](const auto &a, const auto&b) { return compare(a, b); }
    );

    auto top = std::move(m_nodes.back());
    m_nodes.pop_back();
    return top;
}

bool PriorityFrontier::empty() const { return m_nodes.empty(); }
size_t PriorityFrontier::size() const { return m_nodes.size(); }

std::shared_ptr<Node> PriorityFrontier::contains(const State& s) const {
    auto found = std::find_if(m_nodes.begin(), m_nodes.end(), [&](const std::shared_ptr<Node>& node) {
        return node->state() == s;
    });
    if(found != m_nodes.end()) 
        return *found;
    return nullptr;
}

void PriorityFrontier::remove(const State& s) {
    auto it = std::remove_if(
        m_nodes.begin(), 
        m_nodes.end(),
        [&](const std::shared_ptr<Node>& n) { return n.get()->state() == s; }
    );

    if (it != m_nodes.end())
    {
        m_nodes.erase(it, m_nodes.end());
    }
    std::make_heap(
        m_nodes.begin(), 
        m_nodes.end(),
        [this](auto& a, auto& b) { return compare(a, b); }
    );
}