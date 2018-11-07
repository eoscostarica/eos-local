#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;

CONTRACT hello : public contract {
  public:
      using contract::contract;

      ACTION hi( name user ) {
         require_auth( user );
         print( "Hello my friend, ", name{user});
      }
};
EOSIO_DISPATCH( hello, (hi))
