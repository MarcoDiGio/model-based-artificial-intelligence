#ifndef NODE_H
#define NODE_H

#include "action.h"
#include "state.h"
#include <memory>
#include <optional>

class Node {
private:
    State                     m_state;
    int                       m_g = 0;
    int                       m_h = 0;
    std::shared_ptr<Node>     m_parent;
    std::unique_ptr<Action>   m_action;

public:

    Node(State initial_state, int heuristic = 0);

    Node(State state,
        int g,
        int h,
        std::shared_ptr<Node> parent,
        std::unique_ptr<Action> action);

    Node(const Node&) = delete;
    Node& operator=(const Node&) = delete;

    Node() = default;
    Node(Node&&) noexcept = default;
    Node& operator=(Node&&) noexcept = default;

    ~Node() = default; 

    const State&          state()  const noexcept { return m_state; }
    int                   g()      const noexcept { return m_g; }
    int                   h()      const noexcept { return m_h; }
    int                   f()      const noexcept { return m_g + m_h; }
    std::shared_ptr<Node> parent() const noexcept { return m_parent; }

    const std::unique_ptr<Action>& action() const noexcept { return m_action; }

    void set_g(int g) noexcept { m_g = g; }
    void set_h(int h) noexcept { m_h = h; }

    bool isRoot() const noexcept { return m_parent == nullptr; }
};

#endif
