import React from 'react'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import {
  AppBar,
  Toolbar,
  Grid,
  Button,
  InputAdornment,
  IconButton,
  TextField,
  Typography,
  MenuItem,
  Menu
} from '@material-ui/core'
import {
  ChatBubbleOutline,
  Settings,
  Fingerprint
} from '@material-ui/icons'
import { fade } from '@material-ui/core/styles/colorManipulator'
import { Link } from '@reach/router'
import { translate } from 'react-i18next'

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
  },
  menuLink: {
    textDecoration: 'none'
  },
  textFieldInput: {
    color: 'white'
  },
  textFieldFormLabel: {
    color: 'white !important'
  }
})

const MainTopBar = ({
  classes,
  handleDrawerToggle,
  handleMenu,
  anchorEl,
  open,
  onClose,
  t
}) => (
  <AppBar position='absolute'>
    <Toolbar>
      <Link to='/' className={classes.link}>
        <Typography variant='title' color='inherit' className={classes.title}>
            EOS Grettings
        </Typography>
      </Link>
      <div className={classes.grow} />

      <div className={classes.grow} />
      <Link to='/account' className={classes.link}>
        <IconButton color='inherit'>
          <Fingerprint />
        </IconButton>
      </Link>
      <IconButton color='inherit' onClick={handleMenu}>
        <Settings />
      </IconButton>
      <Menu
        id='menu-appbar'
        anchorEl={anchorEl}
        anchorOrigin={{
          vertical: 'top',
          horizontal: 'right'
        }}
        transformOrigin={{
          vertical: 'top',
          horizontal: 'right'
        }}
        open={open}
        onClose={onClose}
      >
        <MenuItem onClick={onClose}><Link to='/settings' className={classes.menuLink}>Settings</Link></MenuItem>
      </Menu>
    </Toolbar>
    <Grid container alignItems='center'>
      <Grid item xs={10}>
        <TextField
          id='filled-full-width'
          label={t('inputLabel')}
          style={{ margin: 8 }}
          placeholder={t('inputPlaceholder')}
          fullWidth
          variant='filled'
          inputStyle={{ backgroundColor: 'red' }}
          InputProps={{
            startAdornment: (
              <InputAdornment position='start' style={{ marginTop: 14, color: '#fff' }}>
                <ChatBubbleOutline />
              </InputAdornment>
            ),
            classes: {
              root: classes.textFieldRoot,
              input: classes.textFieldInput
            }
          }}
          InputLabelProps={{
            className: classes.textFieldFormLabel
          }}
        />
      </Grid>
      <Grid item xs={2} style={{ justifyContent: 'center', display: 'flex' }}>
        <Button
          className='textPrimary'
          variant='contained'
          size='small'
          color='secondary'
          style={{ color: '#fff' }}
        >
          <Fingerprint />
            Publish
        </Button>
      </Grid>
    </Grid>
  </AppBar>
)

MainTopBar.propTypes = {
  classes: PropTypes.object,
  handleDrawerToggle: PropTypes.func,
  handleMenu: PropTypes.func,
  anchorEl: PropTypes.string,
  open: PropTypes.boolean,
  onClose: PropTypes.func,
  t: PropTypes.funx
}

export default withStyles(styles)(translate('translations')(MainTopBar))
