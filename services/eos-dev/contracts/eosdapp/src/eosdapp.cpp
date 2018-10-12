#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>
using namespace eosio;

// Smart Contract Name: dmeetup
// Public actions:
//   update => put the meetup into the multi-index table and sign by the given account

// Replace the contract class name when you start your own project
class dmeetup : public eosio::contract {
  private:
    /// @abi table
    struct meetupstruct {
      account_name  user;      // account name for the user
      std::string   uri;      // the uri of the meetup group's profile
      uint64_t      timestamp; // the store the last update block time

      // primary key
      auto primary_key() const { return user; }      
    };

    // create a multi-index table and support secondary key
    typedef eosio::multi_index< N(meetupstruct), meetupstruct> meetups;

  public:
    using contract::contract;

    /// @abi action
    void update( account_name user, std::string& uri ) {
      // to sign the action with the given account
      require_auth( user );

      meetups obj(_self, _self); // code, scope
      auto meetup = meetups.find(user)
      // create new / update meetup depends whether the user account exist or not
      if (meetup == meetups.end) {
        // insert group
        obj.emplace( _self, [&]( auto& row ) {          
          row.user        = user;
          row.uri        = uri;
          row.timestamp   = now();
        });
      } else {
        // update object
        obj.modify( meetup, _self, [&]( auto& row ) {
          address.uri        = uri;
          address.timestamp   = now();
        });
      }
    }
};

// specify the contract name, and export a public action: update
EOSIO_ABI( dmeetup, (update) )
