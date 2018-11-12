import React, { Component } from 'react'
import { withNamespaces } from 'react-i18next'
import PropTypes from 'prop-types'

import Home from 'components/Home'

class HomeContainer extends Component {
  render () {
    const { t } = this.props

    return (
      <Home
        inputLabel={t('HomeInputLabel')}
        inputPlaceholder={t('HomeInputPlaceholder')}
      />
    )
  }
}

HomeContainer.propTypes = {
  t: PropTypes.func.isRequired
}

export default withNamespaces('home')(HomeContainer)
