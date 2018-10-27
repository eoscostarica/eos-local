import React from 'react'
import PropTypes from 'prop-types'

const src = {
  menu: require('./menu.svg')
}

const Icon = ({ name, size = 16, ...props }) => (
  <button
    style={{
      alignItems: 'center',
      background: 'none',
      border: 0,
      display: 'flex',
      height: size,
      justifyContent: 'center',
      padding: 0,
      width: size
    }}
    {...props}
  >
    <img
      alt={name}
      src={src[name]}
      style={{
        height: size,
        width: size
      }}
    />
  </button>
)

Icon.propTypes = {
  name: PropTypes.string.isRequired,
  size: PropTypes.number.isRequired
}

export default Icon
