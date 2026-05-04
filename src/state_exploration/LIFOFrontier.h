#ifndef LIFO_FRONTIER_H
#define LIFO_FRONTIER_H

#include <deque>
#include <memory>
#include "frontier.h"

class LIFOFrontier : public Frontier {
private:
    std::deque<std::shared_ptr<Node>> m_nodes;

public:
    LIFOFrontier();

    void push(std::shared_ptr<Node> node) override;
    std::shared_ptr<Node> pop() override;
    
    bool empty() const override;
    size_t size() const override;
    
    std::shared_ptr<Node> contains(const State& s) const override;
    void remove(const State& s) override;
};

#endif