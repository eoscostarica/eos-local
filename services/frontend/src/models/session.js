import { getUserEOSAccout, forgetUserEOSAccout } from 'services/scatter'

const initialState = {
  account: null
}

const session = {
  state: initialState,
  reducers: {
    logout () {
      return initialState
    },
    setAccount (state, account) {
      return {
        ...state,
        account
      }
    }
  },
  effects: {
    async getUserEOSAccount () {
      this.setAccount(await getUserEOSAccout())
    },
    async forgetEOSAccount () {
      await forgetUserEOSAccout()
      this.logout()
    }
  }
}

export default session
