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
