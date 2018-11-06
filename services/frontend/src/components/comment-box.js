import React from 'react'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import {
  Grid,
  Paper,
  Typography
} from '@material-ui/core'

const styles = theme => ({
  commentBox: {
    padding: 10,
    marginTop: 20
  }
})

const CommentBox = ({
  classes,
  title,
  body,
  city,
  hour
}) => (
  <Paper elevation={1} className={classes.commentBox}>
    <Typography variant='subtitle1'>
      {title}
    </Typography>
    <Typography variant='caption'>
      {body}
    </Typography>
    <Grid container style={{ marginTop: 10 }}>
      <Grid item xs={6}>
        <Typography variant='caption'>{city}</Typography>
      </Grid>
      <Grid item xs={6} container justify='flex-end' alignItems='flex-end'>
        <Typography variant='caption'>{hour}</Typography>
      </Grid>
    </Grid>
  </Paper>
)

CommentBox.propTypes = {
  classes: PropTypes.object,
  title: PropTypes.string,
  body: PropTypes.string,
  city: PropTypes.string,
  hour: PropTypes.string
}

export default withStyles(styles)(CommentBox)
