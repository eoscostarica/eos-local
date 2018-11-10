#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>
#include "include/eoslocal_greet.hpp"

using namespace eosio;

CONTRACT eoslocal : public eosio::contract {

  public:
    using contract::contract;

    eoslocal(name receiver, name code, datastream<const char *> ds) : contract(receiver, code, ds) {}

    ACTION greet(uint64_t id, name user, std::string msg )
    {
      require_auth(user);
        greetings_table v_greetings(_code, _code.value);

        v_greetings.emplace(user, [&](auto &row) {
            row.id = id;
            row.key = user;
            row.msg = msg;
        });
    }

  private:
     TABLE greetings_table_struct {
      uint64_t id;
      name key;
      std::string msg;

      uint64_t primary_key() const { return id; }
    };

    typedef eosio::multi_index<"greetings"_n, greetings_table_struct> greetings_table;
};
EOSIO_DISPATCH( eoslocal, (greet) );
