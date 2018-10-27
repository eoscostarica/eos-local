import React from 'react'
import { Field } from 'formik'
import { TextField as MaterialTextField } from 'formik-material-ui'

import FormControl from './formControl'

const TextField = props => (
  <FormControl>
    <Field fullWidth component={MaterialTextField} {...props} />
  </FormControl>
)

export default TextField
