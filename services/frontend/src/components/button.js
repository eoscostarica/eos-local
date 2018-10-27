import React from 'react'
import { Button as MaterialButton } from '@material-ui/core'

import FormControl from './formControl'

const Button = ({ ...props }) => (
  <FormControl>
    <MaterialButton {...props} />
  </FormControl>
)

export default Button
