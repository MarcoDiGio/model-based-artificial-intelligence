#ifndef ROMANIA_PROBLEM_H
#define ROMANIA_PROBLEM_H

#include <unordered_map>
#include <memory>
#include <vector>
#include "../problem.h"
#include "RomaniaAction.h"

class RomaniaProblem : public Problem {
private:
    std::unordered_map<std::string, std::vector<RomaniaAction>> m_map;
public:
    RomaniaProblem();

    const State initial_state() const override;
    bool is_goal(const State& state) const override;

    std::vector<std::unique_ptr<Action>> actions(const State& state) const override;

    State result(const State& state, const Action& action) const override;

    double heuristic(const State& state) const override;
};

#endif