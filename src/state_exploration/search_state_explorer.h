#ifndef SEARCH_ENGINE_H
#define SEARCH_ENGINE_H

#include "problem.h"
#include "frontier.h"
#include "node.h"
#include <memory>

namespace Search {
    std::shared_ptr<Node> graph_search(const Problem& problem, Frontier& frontier, bool use_heuristics = false);
}

#endif