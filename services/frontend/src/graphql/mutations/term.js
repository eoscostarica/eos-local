import gql from 'graphql-tag'

export const clearTermQuery = gql`
  mutation clearTerm {
    clearTerm @client
  }
`

export const updateTermQuery = gql`
  mutation updateTerm($text: String) {
    updateTerm(text: $text) @client
  }
`
