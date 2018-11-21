import gql from 'graphql-tag'

export const getGreetingsQuery = gql`
{
  greetings{
    created_eosacc,
    greeting,
    created_at
  }
}
`
