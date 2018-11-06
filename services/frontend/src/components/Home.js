import React from 'react'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import {
  Grid,
  Paper
} from '@material-ui/core'

import CommentBox from './comment-box'

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
        <CommentBox
          title='12 LETTERNAME'
          body='is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in'
          city='New York'
          hour='3H'
        />
        <CommentBox
          title='12 LETTERNAME'
          body='is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in'
          city='New York'
          hour='3H'
        />
      </Paper>
    </Grid>
  </Grid>
)

Home.propTypes = {
  classes: PropTypes.object
}

export default withStyles(styles)(Home)
