import React from 'react'
import { translate } from 'react-i18next'
import PropTypes from 'prop-types'

const NotFound = ({ t }) => <h1>{t('notFound')}</h1>

NotFound.propTypes = {
  t: PropTypes.func.isRequired
}

export default translate('translations')(NotFound)
