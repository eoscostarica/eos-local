import React from 'react'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import {
  Grid,
  Paper
} from '@material-ui/core'

import { Query } from 'react-apollo'

import CommentBox from './comment-box'

import { getGreetingsQuery } from 'graphql/queries'

const styles = theme => ({
  grow: {
    flexGrow: 1
  },
  container: {
    backgroundColor: '#E0E0E0',
    paddingTop: 20,
    paddingLeft: 10,
    paddingRight: 10,
    height: '100vh'
  }
})

const Home = ({
  classes
}) => (
  <Grid container>
    <Grid item xs={12}>
      <Paper className={classes.container}>
        <Query query={getGreetingsQuery}>
          {
            ({ data }) => {
              // need to validate more
              if (data.greetings) {
                return data.greetings.map((g, index) => {
                  return <CommentBox key={index}
                    title={g.created_eosacc}
                    body={g.greeting}
                    hour={g.created_at}
                  />
                })
              } else {
                // need to validite against network
                return 'loading'
              }
            }
          }
        </Query>
      </Paper>
    </Grid>
  </Grid>
)

Home.propTypes = {
  classes: PropTypes.object
}

export default withStyles(styles)(Home)
