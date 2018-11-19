import gql from 'graphql-tag'

export const getGreetingsQuery = gql`
{
  allGreetings {
    edges {
      node {
        createdEosacc,
        greeting
      }
    }
  }
}
`
