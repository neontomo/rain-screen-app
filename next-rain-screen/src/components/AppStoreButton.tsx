import Image from 'next/image'
import Link from 'next/link'
import { links } from '@/utils/links'
import { webhookAppDownloaded } from '@/utils/webhooks'

function AppStoreButton({
  size = 200,
  onClick
}: {
  size?: number
  onClick?: () => void
}) {
  return (
    <Link
      className={`zoom-on-hover`}
      title={'download in app store'}
      target="_blank"
      href={links.download.href}
      onClick={async () => {
        webhookAppDownloaded()
      }}>
      <Image
        src="/img/download.svg"
        alt="Hero image"
        width={size}
        height={size}
        className="zoom-on-hover cursor-pointer hover:opacity-80"
      />
    </Link>
  )
}

export default AppStoreButton
