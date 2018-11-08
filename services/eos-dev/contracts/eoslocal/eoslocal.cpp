#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>
#include "include/eoslocal_greet.hpp"

using namespace eosio;

CONTRACT eoslocal : public eosio::contract {

  public:
    using contract::contract;
/// @abi action
    ACTION greet( name user ) 
    {
      require_auth( user );
      Greet_Action greetd_act;
      greetd_act.greet_data = "Text of Greeting Section";
      print("User-> %s your call to greet: %s", name{user});
    }

/// @abi action
    ACTION add() 
    {
      print("your call to add");
    }
/// @abi action
    ACTION result()
    {
      print("your call to result");
    }
};
//EOSIO_ABI( eoslocal, (greet) (add) (result) )
EOSIO_DISPATCH( eoslocal, (greet) (add) (result) );
