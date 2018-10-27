import ApolloClient from 'apollo-boost'

const client = new ApolloClient({
  uri: process.env.GRAPHQL_URL
})

export default client
