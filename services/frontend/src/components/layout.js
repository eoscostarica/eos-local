import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import Hidden from '@material-ui/core/Hidden'
import MainTopBar from 'components/app-bar'
import MainDrawer from 'components/main-drawer'

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
    padding: theme.spacing.unit * 3
  }
})

class Layout extends Component {
  state = {
    mobileNavOpen: false
  }

  handleDrawerToggle = () =>
    this.setState({ mobileNavOpen: !this.state.mobileNavOpen })

  render () {
    const { classes, children } = this.props
    return (
      <div className={classes.root}>
        <MainTopBar handleDrawerToggle={this.handleDrawerToggle} />
        <Hidden mdUp>
          <MainDrawer
            variant='mobile'
            open={this.state.mobileNavOpen}
            onClose={this.handleDrawerToggle}
          />
        </Hidden>
        <Hidden smDown implementation='css'>
          <MainDrawer />
        </Hidden>
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
  classes: PropTypes.object
}

export default withStyles(styles, { withTheme: true })(Layout)
