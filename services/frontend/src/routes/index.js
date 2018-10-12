import Home from './home'
import Account from './account'
import Settings from './settings'

export default [
  {
    path: '/',
    Component: Home,
    drawerLabel: 'drawerLinkHome'
  },
  {
    path: '/settings',
    Component: Settings,
    drawerLabel: 'drawerLinkSettings'
  },
  {
    path: '/account',
    Component: Account
  }
]
