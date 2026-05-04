#ifndef PRIORITY_FRONTIER_H
#define PRIORITY_FRONTIER_H

#include "frontier.h"
#include <vector>
#include <memory>
#include <functional>

class PriorityFrontier : public Frontier {
public:
    enum class Order { MIN, MAX }; 

private:
    std::vector<std::shared_ptr<Node>> m_nodes;
    PriorityFrontier::Order m_order;

    bool compare(const std::shared_ptr<Node>& a, const std::shared_ptr<Node>& b) const;

public:
    explicit PriorityFrontier(Order order = Order::MIN);

    void push(std::shared_ptr<Node> node) override;
    std::shared_ptr<Node> pop() override;

    bool empty() const override;
    size_t size() const override;

    std::shared_ptr<Node> contains(const State& s) const override;
    void remove(const State& s) override;
    
};

#endif