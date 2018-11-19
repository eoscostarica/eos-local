import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'redux-render'
import { PersistGate } from 'redux-persist/lib/integration/react'
import { getPersistor } from '@rematch/persist'
import { MuiThemeProvider, CssBaseline } from '@material-ui/core'
import { I18nextProvider } from 'react-i18next'
import { ApolloProvider } from 'react-apollo'

import store from './config/store'
import theme from './config/theme'
import i18n from './config/i18n'
import App from './app'
import ApolloClient from './graphql/'
import * as serviceWorker from './serviceWorker'

ReactDOM.render(
  <Provider store={store}>
    <PersistGate persistor={getPersistor()}>
      <I18nextProvider i18n={i18n}>
        <MuiThemeProvider theme={theme}>
          <CssBaseline />
          <ApolloProvider client={ApolloClient}>
            <App />
          </ApolloProvider>
        </MuiThemeProvider>
      </I18nextProvider>
    </PersistGate>
  </Provider>,
  document.getElementById('root')
)

serviceWorker.unregister()
