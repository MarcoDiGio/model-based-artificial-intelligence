#ifndef ROMANIA_ACTION_H
#define ROMANIA_ACTION_H

#include "../action.h"
#include <iostream>

class RomaniaAction : public Action {
private:
    std::string m_destination;
    int m_cost;
public:
    ~RomaniaAction() = default;

    RomaniaAction(const std::string& dest, int c)
        : m_destination{ dest }, m_cost{ c } 
    {}
    
    void toString() const {
        std::cout << "Going to " << m_destination;
    }
    
    double getCost() const {
        return m_cost;
    }

    const std::string& getDestination() const { return m_destination; }
};

#endif