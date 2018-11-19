import { withClientState } from 'apollo-link-state'
import flow from 'lodash.flow'
import { store as homeStore } from './states/home'

const stores = [
  homeStore
  // place new stores here
]

// get array of with only the attribute specified
const filterStores = (attrName) => (list) => list.map((obj) => obj[attrName])

// reduce array into a object
const reduceProps = () => (list = []) => list.reduce((acc, newValue) => ({ ...acc, ...newValue }), {})

// create client state into one
const mergeStores = (attrName) => flow(
  filterStores(attrName),
  reduceProps()
)

const createClientState = (cache) => {
  const defaults = mergeStores('defaults')(stores)
  const mutations = mergeStores('mutations')(stores)

  return withClientState({
    cache,
    defaults,
    resolvers: {
      Mutation: mutations
    }
  })
}

export default createClientState
