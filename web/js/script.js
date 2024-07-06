var slideIndex = 1

function cycleImages(n) {
  const slideshowImages = document.querySelectorAll('.slideshow-img')
  let i

  slideIndex =
    n > slideshowImages.length ? 1 : n < 1 ? slideshowImages.length : n

  for (i = 0; i < slideshowImages.length; i++) {
    slideshowImages[i].classList.add('hidden')
  }

  slideshowImages[slideIndex - 1].classList.remove('hidden')
}

function generateRainDrop() {
  const randomDecimal = (min, max) => Math.random() * (max - min) + min

  const rainDrop = document.createElement('hr')
  const leftPosition = randomDecimal(0, 120)
  const duration = randomDecimal(1, 2)
  const delay = randomDecimal(0.5, 5)

  rainDrop.style.left = `${leftPosition}vw`
  rainDrop.style.animation = `rain ${duration}s linear ${delay}s infinite`

  return rainDrop
}

const webhookHandler = async (url, text, action) => {
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

const webhookAppDownloaded = async () => {
  const text = 'someone DOWNLOADED rain screen! :D 🌧️'
  const url =
    'https://discord.com/api/webhooks/1258813190633164845/rIt83T7hd38xhsmYaMGDhltA72kGUFMKX4A0TPciz7C54byKO_UjV7gGVszijW6zT4-l'

  await webhookHandler(url, text)
}

const webhookAppVisited = async () => {
  const text = 'someone VISITED rain screen! :-) 🌧️'
  const url =
    'https://discord.com/api/webhooks/1258897465071898714/ww33XwlsIPi8WsECu1qi36nCFRxbt_FgipGZMl3G_5Xy8bw1X4pEiXJR3t3Om91-s0-r'

  await webhookHandler(url, text)
}

for (let i = 0; i < 200; i++) {
  document.getElementById('rain').appendChild(generateRainDrop())
}

document.getElementById('previous').addEventListener('click', () => {
  cycleImages((slideIndex -= 1))
})

document.getElementById('next').addEventListener('click', () => {
  cycleImages((slideIndex += 1))
})

cycleImages(slideIndex)

document.querySelectorAll('.appstore-button').forEach((button) => {
  button.addEventListener('click', () => {
    webhookAppDownloaded()
  })
})

document
  .querySelector('.appstore-button-footer')
  .addEventListener('click', () => {
    webhookAppDownloaded()
  })

webhookAppVisited()

// nothing to see here
// move along

// ...

// seriously
// you can leave now
// there's nothing else here
// go on. shoo.
// coffee is that way! ---------------->

// ...

// fine, you win
// here's a cookie 🍪
// oh, you're gluten free? ffs.
// i'm an app dev not a baker.
// you're lucky i'm not a baker.
// i'd be a terrible baker.
// i can't even make toast.
// ok actually i can make toast, but every time it looks different.
// uh, i'm going on a tangent here.

// if you made it this far, you're a legend. let me know by connecting on x.
// https://twitter.com/neontomo

// ok, bye now. 👋 🌧️

/*

 _   _                 _
| | | |               | |
| |_| |__   __ _ _ __ | | __  _   _  ___  _   _
| __| '_ \ / _` | '_ \| |/ / | | | |/ _ \| | | |
| |_| | | | (_| | | | |   <  | |_| | (_) | |_| |_
 \__|_| |_|\__,_|_| |_|_|\_\  \__, |\___/ \__,_(_)
                               __/ |
                              |___/
                                                            
*/
