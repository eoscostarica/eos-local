import gql from 'graphql-tag'

export const termQuery = gql`
  query GetTerm {
    saveTerm @client
  }
`
