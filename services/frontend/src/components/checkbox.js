import React from 'react'
import { Field } from 'formik'
import { InputLabel } from '@material-ui/core'
import { Checkbox as MaterialCheckbox } from 'formik-material-ui'
import PropTypes from 'prop-types'

import FormControl from './formControl'

const Checkbox = ({ ...props }) => (
  <FormControl>
    <Field component={MaterialCheckbox} {...props} />
    <InputLabel htmlFor={props.name}>{props.label}</InputLabel>
  </FormControl>
)

Checkbox.propTypes = {
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired
}

export default Checkbox
