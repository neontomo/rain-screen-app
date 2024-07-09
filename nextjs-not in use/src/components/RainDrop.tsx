function RainDrop() {
  return (
    <hr
      style={{
        left: `${Math.random() * 120}vw`,
        animation: `rain ${Math.random() * 2}s linear ${
          Math.random() * 5
        }s infinite`,
        opacity: Math.random() * 0.5
      }}
    />
  )
}

export default RainDrop
