#include "state.h"

State::State(std::string name) 
    :
        m_name(std::move(name))
    {}