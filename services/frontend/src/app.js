import React from 'react'
import { Router } from '@reach/router'

import Layout from 'components/layout'
import NotFound from 'routes/not-found'
import routes from 'routes'

const App = () => (
  <Layout>
    <Router>
      <NotFound default />
      {routes.map(({ path, Component }) => (
        <Component key={`path-${path}`} path={path} />
      ))}
    </Router>
  </Layout>
)

export default App
