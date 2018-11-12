import React from 'react'
import { withNamespaces } from 'react-i18next'
import PropTypes from 'prop-types'

const NotFound = ({ t }) => <h1>{t('notFound')}</h1>

NotFound.propTypes = {
  t: PropTypes.func.isRequired
}

export default withNamespaces('global')(NotFound)
