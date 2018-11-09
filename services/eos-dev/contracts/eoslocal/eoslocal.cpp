#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>
#include "include/eoslocal_greet.hpp"

using namespace eosio;

CONTRACT eoslocal : public eosio::contract {

  public:
    using contract::contract;

    eoslocal(name receiver, name code, datastream<const char *> ds) : contract(receiver, code, ds) {}

/// @abi action
    ACTION greet( name user, std::string msg ) 
    {
      require_auth(user);
        greetings_type v_greetings(_code, _code.value);
        auto iterator = v_greetings.find(user.value);

        if (iterator == v_greetings.end())
        {
            //The user isn't in the table
            v_greetings.emplace(user, [&](auto &row) {
                row.key = user;
                row.msg = msg;
            });
        }
        else
        {
            //The user is in the table
            v_greetings.modify(iterator, user, [&](auto &row) {
                row.key = user;
                row.msg = msg;
            });
        }
    }

  private:
    struct greetings {
	name key;
	std::string msg;

	uint64_t primary_key() const { return key.value;}
    };

    typedef eosio::multi_index<"greet"_n, greetings> greetings_type;
};
EOSIO_DISPATCH( eoslocal, (greet) );
