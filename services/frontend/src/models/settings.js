// Initial state
const initialState = {
  language: 'en',
  notifications: true
}

const settings = {
  state: initialState,
  reducers: {
    setSettings (state, { key, value }) {
      return {
        ...state,
        [key]: value
      }
    }
  }
}

export default settings
