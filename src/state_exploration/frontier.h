#ifndef FRONTIER_H
#define FRONTIER_H

#include "node.h"

class Frontier {
public:
    virtual ~Frontier() = default;

    virtual void push(std::shared_ptr<Node> node) = 0;
    virtual std::shared_ptr<Node> pop() = 0;

    virtual bool empty() const = 0; 

    virtual std::shared_ptr<Node> contains(const State& state) const = 0;
    virtual void remove(const State& state) = 0;

    virtual size_t size() const = 0;
};

#endif
