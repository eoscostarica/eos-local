import React from 'react'
import { Redux } from 'redux-render'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import { translate } from 'react-i18next'
import List from '@material-ui/core/List'
import ListItem from '@material-ui/core/ListItem'
import ListItemIcon from '@material-ui/core/ListItemIcon'
import ListItemSecondaryAction from '@material-ui/core/ListItemSecondaryAction'
import ListItemText from '@material-ui/core/ListItemText'
import Typography from '@material-ui/core/Typography'
import Switch from '@material-ui/core/Switch'
import Language from '@material-ui/icons/Language'
import NotificationsIcon from '@material-ui/icons/Notifications'

const styles = theme => ({
  root: {}
})

class Settings extends React.Component {
  state = {
    checked: ['language']
  }

  handleToggle = (value, currentValue, dispatch) => () => {
    const { i18n } = this.props

    if (value === 'language') {
      let lang = currentValue === 'en' ? 'es' : 'en'
      i18n.changeLanguage(lang)
      dispatch.settings.setSettings({ key: value, value: lang })
    } else if (value === 'notifications') {
      dispatch.settings.setSettings({ key: value, value: !currentValue })
    }
  }

  render () {
    const { classes, t } = this.props

    return (
      <Redux
        selector={({ settings: { language, notifications } }) => ({
          language,
          notifications
        })}
      >
        {({ language, notifications }, dispatch) => (
          <div className={classes.root}>
            <Typography
              variant='headline'
              style={{ textAlign: 'center', paddingTop: 20, paddingBottom: 20 }}
            >
              {t('settingsTitle')}
            </Typography>
            <List>
              <ListItem>
                <ListItemIcon>
                  <Language />
                </ListItemIcon>
                <ListItemText primary={t('settingsLanguages')} />
                <ListItemSecondaryAction>
                  <Switch
                    onChange={this.handleToggle('language', language, dispatch)}
                    checked={language === 'en'}
                  />
                </ListItemSecondaryAction>
              </ListItem>
              <ListItem>
                <ListItemIcon>
                  <NotificationsIcon />
                </ListItemIcon>
                <ListItemText primary={t('settingsNotifications')} />
                <ListItemSecondaryAction>
                  <Switch
                    onChange={this.handleToggle(
                      'notifications',
                      notifications,
                      dispatch
                    )}
                    checked={notifications}
                  />
                </ListItemSecondaryAction>
              </ListItem>
            </List>
          </div>
        )}
      </Redux>
    )
  }
}

Settings.propTypes = {
  classes: PropTypes.object.isRequired,
  t: PropTypes.func.isRequired,
  i18n: PropTypes.object.isRequired
}

export default withStyles(styles)(translate('translations')(Settings))
