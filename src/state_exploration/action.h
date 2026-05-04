#ifndef ACTION_H
#define ACTION_H

#include <string>

/*
    The action is an action taken by the agent to change state.
    Idk what to put here atm
*/
class Action{
public:
    virtual ~Action() = default;
    virtual double getCost() const = 0;
};

#endif
