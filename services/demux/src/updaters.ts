import { BlockInfo } from "demux"

const storeGreetingMessage = async (db: any, payload: any, blockInfo: BlockInfo) => {

  console.info("\n\n==== Greeting Updater ====")
  console.info("\n\nUpdater Payload >>> \n", payload)
  console.info("\n\nUpdater Block Info >>> \n", blockInfo)

  const data = {
    greeting: payload.data.msg,
    created_block: blockInfo.blockNumber,
    created_trx: payload.transactionId,
    created_at: blockInfo.timestamp,
    created_eosacc: payload.data.user,
  }

  console.info("DB Data to Insert >>> ", data)

  const res = await db.greetings.insert(data)

  console.info("DB State Result >>> ", res)
}

const updaters = [
  {
    actionType: "eoslocal::greet",
    updater: storeGreetingMessage,
  }
]

export { updaters }
