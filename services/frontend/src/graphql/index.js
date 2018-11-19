import { ApolloClient } from 'apollo-client'
import { InMemoryCache } from 'apollo-cache-inmemory'
import { HttpLink } from 'apollo-link-http'
import { onError } from 'apollo-link-error'

import { ApolloLink } from 'apollo-link'
import createState from './client-state'

const cache = new InMemoryCache()

const stateLink = createState(cache)

const onErrorCB = ({ graphQLErrors, networkError }) => {
  if (graphQLErrors) {
    graphQLErrors.map(({ message, locations, path }) =>
      console.log(
        `[GraphQL error]: Message: ${message}, Location: ${locations}, Path: ${path}`
      )
    )
  }
  if (networkError) console.log(`[Network error]: ${networkError}`)
}

const requestHTTP = new HttpLink({
  uri: process.env.REACT_APP_GRAPHQL_URL,
  credentials: 'same-origin'
})

const client = new ApolloClient({
  connectToDevTools: true,
  link: ApolloLink.from([
    onError(onErrorCB),
    stateLink,
    requestHTTP
  ]),
  cache
})

export default client
