#ifndef PROBLEM_H
#define PROBLEM_H

#include "state.h"
#include "action.h"
#include <memory>
#include <vector>

/*
 * Definisce il problema da risolvere (modello del mondo).
 * - stato iniziale
 * - test di goal
 * - azioni possibili da uno stato
 * - funzione di transizione (result)
 */
class Problem {
public:
    virtual ~Problem() = default;

    // returns initial state of the problem
    virtual const State initial_state() const = 0;

    // checks if state is goal
    virtual bool is_goal(const State& state) const = 0;
    // actions available when in the state
    virtual std::vector<std::unique_ptr<Action>> actions(const State& state) const = 0;
    // result of the action in the state
    virtual State result(const State& state, const Action& action) const = 0;

    // heuristic of a state are a responsibility of the problem
    virtual double heuristic(const State& state) const = 0;
};

#endif
