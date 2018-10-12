const initialState = {
  pathname: window.location.pathname,
  data: {}
}

const location = {
  state: initialState,

  reducers: {
    setLocation (state, pathname, data = {}) {
      return {
        ...state,
        pathname,
        data
      }
    }
  }
}

export const locationChangeListener = ({ dispatch, getState }) => {
  let {
    location: { pathname: currentPathname }
  } = window

  window.setInterval(() => {
    const {
      location: { pathname }
    } = window
    if (currentPathname !== pathname) {
      currentPathname = pathname
      dispatch.location.setLocation(pathname)
    }
  }, 400)
}

export default location
