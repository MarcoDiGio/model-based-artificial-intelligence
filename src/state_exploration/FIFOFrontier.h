#ifndef FIFO_FRONTIER_H
#define FIFO_FRONTIER_H

#include "frontier.h"
#include "node.h"
#include <deque>
#include <memory>

class FIFOFrontier : public Frontier {
private:
    std::deque<std::shared_ptr<Node>> m_nodes;

public:
    FIFOFrontier();

    void push(std::shared_ptr<Node> node) override;
    std::shared_ptr<Node> pop() override;
    bool empty() const override;
    size_t size() const override;
    std::shared_ptr<Node> contains(const State& s) const override;
    void remove(const State& s) override;
};

#endif