export const webhookHandler = async (url: string, text: string) => {
  if (location.hostname === 'localhost' || location.hostname === '') {
    text = `LOCALHOST: ${text}`
  }

  await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      content: text
    })
  })
}

export const webhookAppDownloaded = async () => {
  const text = 'someone DOWNLOADED rain screen! :D 🌧️'
  const url =
    'https://discord.com/api/webhooks/1258813190633164845/rIt83T7hd38xhsmYaMGDhltA72kGUFMKX4A0TPciz7C54byKO_UjV7gGVszijW6zT4-l'

  await webhookHandler(url, text)
}

export const webhookAppVisited = async () => {
  const text = 'someone VISITED rain screen! :-) 🌧️'
  const url =
    'https://discord.com/api/webhooks/1258897465071898714/ww33XwlsIPi8WsECu1qi36nCFRxbt_FgipGZMl3G_5Xy8bw1X4pEiXJR3t3Om91-s0-r'

  await webhookHandler(url, text)
}
