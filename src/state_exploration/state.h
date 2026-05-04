#ifndef STATE_H
#define STATE_H

#include <string>
#include <string_view>

class State{
private:
    std::string m_name;
public:
    State(std::string name);

    std::string getName() const { return m_name; };
    bool operator==(const State& other) const { return m_name == other.m_name; }
};

namespace std {
    template <>
    struct hash<State> {
        std::size_t operator()(const State& s) const noexcept {
            // Sfruttiamo l'hash già esistente per le stringhe
            return std::hash<std::string>{}(s.getName());
        }
    };
}

#endif
