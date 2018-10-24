const logGreeting = (_: any, payload: any) => {
  console.info("Greet invoked ===> Payload:\n", payload)
}

const effects = [
  {
    actionType: "eoslocal::greet",
    effect: logGreeting,
  },
]

export { effects }
