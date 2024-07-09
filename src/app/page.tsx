'use client'
import AppStoreButton from '@/components/AppStoreButton'
import { useState, useEffect } from 'react'
import { links } from '@/utils/links'
import RainDrop from '@/components/RainDrop'
import { webhookAppDownloaded, webhookAppVisited } from '@/utils/webhooks'
import Image from 'next/image'

export default function Home() {
  const amountRainDrops = 200
  const [slideActive, setSlideActive] = useState(0)

  const reviews = ['3621587', '3620667', '3623450', '3620411']

  const slides = [
    '/img/screenshot-1.webp',
    '/img/screenshot-2.webp',
    '/img/screenshot-3.webp',
    'https://www.youtube.com/embed/UUPjqkTDTns?vq=hd1080&loop=1&modestbranding=1&rel=0&cc_load_policy=1&controls=0&disablekb=1&playlist=UUPjqkTDTns'
  ]

  useEffect(() => {
    webhookAppVisited()
  }, [])

  return (
    <main className="w-full max-w-[900px] pb-56 flex flex-col gap-32 justify-center items-center mx-auto">
      <div
        id="rain"
        className="fixed">
        {Array.from({ length: amountRainDrops }).map(
          (rainDrop, index: number) => (
            <RainDrop key={`rain-drop-${index}`} />
          )
        )}
      </div>

      <nav className="flex flex-row w-full fixed top-0 left-0 px-4 py-2 bg-white z-10">
        <a href="/">
          <h4 className="flex flex-row items-center gap-2">
            <Image
              id="icon"
              src="/img/icon.webp"
              alt="icon"
              className="h-6 w-6"
              width={24}
              height={24}
            />
            rain screen
          </h4>
        </a>
      </nav>
      <div className={`hero md:px-16 min-h-screen`}>
        <div className="hero-content flex-col-reverse gap-16 lg:flex-row-reverse items-start">
          <div className="w-full flex flex-col gap-4">
            <h3>features</h3>
            <ul className="flex flex-col gap-2">
              <li>🌧️ pretty rain animations</li>
              <li>🔊 10 different rain/thunder tracks</li>
              <li>
                <span className="subtext">...or add your own mp3s</span>
              </li>
              <li>⚙️ controls for custom experience</li>
              <li>
                <span className="subtext">
                  intensity, direction, speed, amount, volume
                </span>
              </li>
              <li>📺 works on multi-monitor setups</li>
              <li>⚡️ optimised for low resource usage</li>
            </ul>

            <a
              id="product-hunt"
              href="https://www.producthunt.com/posts/rain-screen?embed=true&utm_source=badge-top-post-badge&utm_medium=badge&utm_souce=badge-rain&#0045;screen"
              target="_blank">
              <img
                src="https://api.producthunt.com/widgets/embed-image/v1/top-post-badge.svg?post_id=468288&theme=light&period=daily"
                alt="Rain&#0032;Screen - Make&#0032;your&#0032;Mac&#0032;rain |
            Product Hunt"
              />
            </a>
          </div>
          <div>
            <h1 className="w-full text-4xl font-bold md:text-5xl">
              a cute app to make your computer rain.
            </h1>

            <p className="py-6 lg:w-full">
              great for studying & soothing your nerves. available for macos.
            </p>

            <div className="flex justify-center md:justify-start">
              <AppStoreButton />
            </div>
          </div>
        </div>
      </div>

      <div
        id="reviews-container"
        className="flex flex-col justify-center items-center gap-8">
        <h3>what do people think?</h3>
        <div
          id="reviews"
          className="flex flex-row flex-wrap gap-8 items-center justify-center">
          {reviews.map((review: string, index: number) => (
            <iframe
              key={`review-${index}`}
              style={{ border: 'none' }}
              src={`https://cards.producthunt.com/cards/comments/${review}?v=1`}
              width="300"
              height="300"></iframe>
          ))}
        </div>

        <button
          id="more-reviews"
          onClick={() => {
            window.open(
              'https://www.producthunt.com/posts/rain-screen',
              '_blank'
            )
          }}>
          more reviews
        </button>
      </div>

      <div
        id="screenshots-container"
        className="flex flex-col justify-center items-center gap-8">
        <h3>screenshots</h3>

        <div
          id="slideshow"
          className="px-4">
          {slides.map((slide: string, index: number) =>
            slide.includes('youtube') ? (
              <iframe
                key={`youtube-${index}`}
                className={`slideshow-img video max-w-full ${
                  slideActive === index ? 'active' : 'hidden'
                }`}
                src="https://www.youtube.com/embed/UUPjqkTDTns?vq=hd1080&loop=1&modestbranding=1&rel=0&cc_load_policy=1&controls=0&disablekb=1&playlist=UUPjqkTDTns"
                width="900"
                height="506"
                title="🌧️ I made a study app to make your computer rain...."></iframe>
            ) : (
              <Image
                key={`screenshot-${index}`}
                className={`slideshow-img video ${
                  slideActive === index ? 'active' : 'hidden'
                }`}
                src={slide}
                alt="screenshot"
                width={900}
                height={506}
              />
            )
          )}
          <span className="subtext flex flex-row gap-1 my-1 mb-4 justify-center">
            ps. download the wallpaper
            <a href="img/wallpaper-hd.png">here!</a>
          </span>

          <div
            id="slideshow-controls"
            className="flex flex-row gap-4 items-center justify-center">
            <button
              id="previous"
              onClick={() => {
                setSlideActive(
                  slideActive > 0 ? slideActive - 1 : slides.length - 1
                )
              }}>
              ←
            </button>
            <button
              id="next"
              onClick={() => {
                setSlideActive(
                  slideActive < slides.length - 1 ? slideActive + 1 : 0
                )
              }}>
              →
            </button>
          </div>
        </div>
      </div>

      <div>
        <AppStoreButton />
      </div>

      <footer className="text-xs flex flex-col gap-4 mt-32 flex-wrap items-center justify-center">
        <p>2024 &copy; Tomo Myrman</p>
        <div className="flex flex-row gap-4 flex-wrap items-center justify-center">
          {Object.values(links).map((link, index) => (
            <a
              key={`footer-link-${index}`}
              href={link.href}
              target="_blank"
              rel="noreferrer"
              className="text-blue-500"
              onClick={() => {
                if (link.title === 'download') {
                  webhookAppDownloaded()
                }
              }}>
              {link.title}
            </a>
          ))}
        </div>
      </footer>
    </main>
  )
}
