# Getting Started with EOS

This guide is intended to get you started on your first local account and wallet in order
to develop and deploy dapps locally to your docker instance.

## Spin up a docker instance

We've provided an easy way of getting your env started quick and painless:
```bash
$ yarn eos-dev # Same as: docker-compose up --build
```
Once this has started, just make sure both `nodeos` and `keosd` are up and running.

## Create necessary keys
In order to preserve your keys and passwords, first create a `keys` folder,
you can rename it later if you need to:
```bash
$ mkdir ./keys
$ yarn cleos create key --to-console > keys/owner.key 
$ yarn cleos create key --to-console > keys/active.key 
```

These files will contain both a Private and a Public keys, we'll need them
to create our wallet:
```bash
$ yarn cleos wallet create --name=dapps --to-console | grep '"' | sed 's/"//g' > keys/wallet-password
$ yarn cleos wallet import --name=dapps --private-key=$(cat keys/owner.key | grep Private | cut -d" " -f3)
$ yarn cleos wallet import --name=dapps --private-key=$(cat keys/active.key | grep Private | cut -d" " -f3)
$ yarn cleos wallet import --name=dapps --private-key=5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
```

That last import, is super important, since that's the private key for `eosio` and without it, you can't do
much, since that's the main account that EOS comes with, so you can create new accounts on behalf of `eosio`
on your local instance.

## Creating an account

You'll need accounts for uploading contracts to your network.
```bash
$ PublicOwnerKey=$(cat keys/owner.key | grep Public | cut -d" " -f3)
$ PublicActiveKey=$(cat keys/active.key | grep Public | cut -d" " -f3)
$ yarn cleos create account eosio maindev $PublicOwnerKey $PublicActiveKey
```

And just like that, you're now able to move on to creating your own contracts and publish them to the `maindev` account!

You can create more accounts if you'd like and wallets, so you can simulate transfering Tokens or EOS between those accounts,
and interacting with your locally published smart contracts.

