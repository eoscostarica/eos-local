import { createMuiTheme } from '@material-ui/core/styles'

const theme = createMuiTheme({
  palette: {
    secondary: {
      light: '#fff',
      main: '#00c25b',
      dark: '#00902e'
    }
  },
  overrides: {
    MuiInput: {
      root: {
        backgroundColor: 'red'
      }
    }
  }
})

export default theme
