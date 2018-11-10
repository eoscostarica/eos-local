import { Rpc } from "eosjs2"
import massive from "massive"
import nodeFetch from "node-fetch"

const BLOCK_SYNC_TOLERANCE = process.env.BLOCK_SYNC_TOLERANCE || 10

const NODEOS = process.env.CHAIN_HOST || "http://localhost:8840"
const rpc = new Rpc.JsonRpc(NODEOS, { fetch: nodeFetch })

const dbConfig = {
  user: process.env.DB_USER || "user",
  password: process.env.DB_PASSWORD || "pass",
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT) || 5432,
  database: process.env.DB_NAME || "eoslocal",
  schema: process.env.DB_SCHEMA || "pets",
}

const isChainSync = async (db: any) => {

  const chainInfo = await rpc.get_info()

  const indexState = await db._index_state.findOne({ id: 1 })

  const blocksDiff = chainInfo.head_block_num - indexState.block_number

  return blocksDiff < BLOCK_SYNC_TOLERANCE
}

// main loop that read and updates data
const loop = async (db: any, dbFull: any) => {

  console.info("Data Cleaner Loop")

  const isSync = await isChainSync(db)

  if (isSync) {
    console.info("Chain is synched, starting cleaning tasks")

    // NOTE: add your cleaninig tasks here

  } else {
    console.info("Chain is out of sync, skipping cleaning")
  }

  setTimeout(() => loop(db, dbFull), 500)
}

const init = async () => {
  const db = await massive(dbConfig)
  loop(db[dbConfig.schema], db)
}

init()
