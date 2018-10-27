// TODO: better error handling

import ScatterJS from 'scatterjs-core'
import ScatterEOS from 'scatterjs-plugin-eosjs2'

const network = {
  blockchain: 'eos',
  protocol: 'https',
  host: 'nodes.get-scatter.com',
  port: 443,
  chainId: 'aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906'
}

// singleton service
let scatter = null

export const getScatterInstance = async () => {
  if (scatter) return scatter
  try {
    ScatterJS.plugins(new ScatterEOS())
    const connected = await ScatterJS.scatter.connect('EOSRate')
    if (!connected) {
      alert('You need to install Scatter. Visit to scatter-eos.com')
      return null
    }
    scatter = ScatterJS.scatter
    window.ScatterJS = null
    return scatter
  } catch (err) {
    err && console.log(err)
    alert('Error getting scatter instance')
  }
}

export const getUserEOSAccout = async () => {
  if (!scatter) {
    await getScatterInstance()
  }
  try {
    await scatter.getIdentity({ accounts: [network] })
    // Always use the accounts you got back from Scatter. Never hardcode them even if you are prompting
    // the user for their account name beforehand. They could still give you a different account.
    return scatter.identity.accounts.find(x => x.blockchain === 'eos')
  } catch (err) {
    err && console.log(err)
  }
}

export const forgetUserEOSAccout = async () => scatter.forgetIdentity()
