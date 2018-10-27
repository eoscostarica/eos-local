import React from 'react'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import IconButton from '@material-ui/core/IconButton'
import Typography from '@material-ui/core/Typography'
import MenuIcon from '@material-ui/icons/Menu'
import { fade } from '@material-ui/core/styles/colorManipulator'
import FingerprintIcon from '@material-ui/icons/Fingerprint'
import { Link } from '@reach/router'

const styles = theme => ({
  root: {
    flexGrow: 1
  },
  link: {
    color: 'white',
    textDecoration: 'none'
  },
  grow: {
    flexGrow: 1
  },
  title: {
    display: 'none',
    width: 210,
    [theme.breakpoints.up('sm')]: {
      display: 'block'
    }
  },
  menuButton: {
    marginLeft: -18,
    marginRight: 10,
    [theme.breakpoints.up('md')]: {
      display: 'none'
    }
  },
  search: {
    position: 'relative',
    flexGrow: 1,
    borderRadius: theme.shape.borderRadius,
    backgroundColor: fade(theme.palette.common.white, 0.15),
    '&:hover': {
      backgroundColor: fade(theme.palette.common.white, 0.25)
    },
    marginRight: theme.spacing.unit * 2,
    marginLeft: 0,
    width: '100%',
    [theme.breakpoints.up('sm')]: {
      marginLeft: theme.spacing.unit * 3,
      width: 'auto'
    }
  },
  searchIcon: {
    width: theme.spacing.unit * 9,
    height: '100%',
    position: 'absolute',
    pointerEvents: 'none',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center'
  },
  inputRoot: {
    color: 'inherit',
    width: '100%'
  },
  inputInput: {
    paddingTop: theme.spacing.unit,
    paddingRight: theme.spacing.unit,
    paddingBottom: theme.spacing.unit,
    paddingLeft: theme.spacing.unit * 10,
    transition: theme.transitions.create('width'),
    width: '100%',
    [theme.breakpoints.up('md')]: {
      width: 200
    }
  }
})

const MainTopBar = ({ classes, handleDrawerToggle }) => (
  <AppBar position='absolute'>
    <Toolbar>
      <IconButton
        className={classes.menuButton}
        color='inherit'
        aria-label='Menu'
        onClick={handleDrawerToggle}
      >
        <MenuIcon />
      </IconButton>
      <Link to='/' className={classes.link}>
        <Typography variant='title' color='inherit' className={classes.title}>
          EOS dApp
        </Typography>
      </Link>
      <div className={classes.grow} />

      <div className={classes.grow} />
      <Link to='/account' className={classes.link}>
        <IconButton color='inherit'>
          <FingerprintIcon />
        </IconButton>
      </Link>
    </Toolbar>
  </AppBar>
)

MainTopBar.propTypes = {
  classes: PropTypes.object,
  handleDrawerToggle: PropTypes.func
}

export default withStyles(styles)(MainTopBar)
