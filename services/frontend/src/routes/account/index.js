import React from 'react'
import { translate } from 'react-i18next'
import PropTypes from 'prop-types'
import { Redux } from 'redux-render'
import Component from '@reach/component-component'

const Account = ({ t }) => (
  <Redux selector={state => state.session}>
    {(session, dispatch) => (
      <Component
        didMount={async () => {
          await dispatch.session.getUserEOSAccount()
        }}
      >
        {({ setState, state }) => (
          <React.Fragment>
            <h1>{t('accountTitle')}</h1>
            <p>Your EOS Account Info</p>
            <pre>{JSON.stringify(session.account)}</pre>
          </React.Fragment>
        )}
      </Component>
    )}
  </Redux>
)

Account.propTypes = {
  t: PropTypes.func.isRequired
}

export default translate('translations')(Account)
