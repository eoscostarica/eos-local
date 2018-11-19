import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import compose from 'recompose/compose'

import MainTopBar from 'components/app-bar'
import { withHome } from 'graphql/states/home'

const styles = theme => ({
  root: {
    flexGrow: 1,
    height: '100vh',
    zIndex: 1,
    overflow: 'hidden',
    position: 'relative',
    display: 'flex',
    width: '100%'
  },
  navIconHide: {
    [theme.breakpoints.up('md')]: {
      display: 'none'
    }
  },
  toolbar: theme.mixins.toolbar,
  content: {
    overflow: 'scroll',
    flexGrow: 1,
    backgroundColor: theme.palette.background.default,
    marginTop: 75
  }
})

class Layout extends Component {
  state = {
    mobileNavOpen: false,
    anchorEl: null
  }

  handleDrawerToggle = () =>
    this.setState({ mobileNavOpen: !this.state.mobileNavOpen })

  handleMenu = e => this.setState({ anchorEl: e.currentTarget })

  handleClose = () => this.setState({ anchorEl: null })

  render () {
    const {
      classes,
      children,
      saveTerm,
      updateTermMutation
      // clearTermMutation,
    } = this.props
    const open = Boolean(this.state.anchorEl)
    return (
      <div className={classes.root}>
        <MainTopBar
          handleDrawerToggle={this.handleDrawerToggle}
          handleMenu={this.handleMenu}
          anchorEl={this.state.anchorEl}
          open={open}
          onClose={this.handleClose}
          saveTerm={saveTerm}
          updateTermMutation={updateTermMutation}
        />
        <main className={classes.content}>
          <div className={classes.toolbar} />
          {children}
        </main>
      </div>
    )
  }
}

Layout.propTypes = {
  children: PropTypes.object,
  classes: PropTypes.object,
  saveTerm: PropTypes.string,
  updateTermMutation: PropTypes.func
}

const HomeC = compose(
  withHome
)(withStyles(styles, { withTheme: true })(Layout))

export default HomeC
