import { graphql } from 'react-apollo'
import compose from 'recompose/compose'

import {
  clearTermQuery,
  updateTermQuery
} from 'graphql/mutations'

import {
  termQuery
} from 'graphql/queries'

const defaults = {
  saveTerm: ''
}

// Cache Mutations
const updateTerm = (_obj, { text }, { cache }) => {
  cache.writeQuery({ query: termQuery, data: { saveTerm: text } })
  return null
}

const clearTerm = (_obj, _args, { cache }) => {
  cache.writeQuery({ query: termQuery, data: defaults })
  return null
}

const store = {
  defaults,
  mutations: {
    updateTerm,
    clearTerm
    // add mutations here
  }
}

// Helpers
const termQueryHandler = {
  props: ({ ownProps, data: { saveTerm = '' } }) => ({
    ...ownProps,
    saveTerm
  })
}

const withHome = compose(
  graphql(termQuery, termQueryHandler),
  graphql(updateTermQuery, { name: 'updateTermMutation' }),
  graphql(clearTermQuery, { name: 'clearTermMutation' })
)

export {
  store,
  withHome
}
