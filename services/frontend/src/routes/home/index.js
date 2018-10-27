import React from 'react'
import { translate } from 'react-i18next'
import PropTypes from 'prop-types'

const Home = ({ t }) => <h1>{t('homeTitle')}</h1>

Home.propTypes = {
  t: PropTypes.func.isRequired
}

export default translate('translations')(Home)
