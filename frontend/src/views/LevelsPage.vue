<template>
  <div class="game-container">
    <!-- Character Info -->
    <div class="character-info">
      <div class="character-details">
        <h2>{{ selectedCharacter.name }}</h2>
        <p>{{ selectedCharacter.nationality }} • Age {{ selectedCharacter.age }}</p>
      </div>
      <button @click="goHome" class="home-button">HOME</button>
    </div>

    <!-- Character -->
    <div class="movable-character" :style="{ left: playerX + 'px', top: playerY + 'px' }">
      <img src="/src/images/hero-1.png" alt="Hero Character" class="character-sprite">
    </div>

    <!-- Controls Info -->
    <div class="controls-info">
      <p>Use WASD to move around</p>
    </div>
  </div>
</template>

<script>
import videoSrc from '../video/0_Pixel_Art_Night_3840x2160.mp4?url'

export default {
  name: 'LevelsPage',
  data() {
    return {
      // Character Data (from HomePage selection)
      selectedCharacter: {
        name: 'Alex Thunderstrike',
        nationality: 'Nordic',
        age: 24,
        health: [1, 2, 3, 4, 5]
      },
      
      // Player Position
      playerX: 400,
      playerY: 300
    }
  },
  mounted() {
    this.setupKeyboardControls()
  },
  beforeUnmount() {
    this.cleanupControls()
  },
  methods: {
    setupKeyboardControls() {
      document.addEventListener('keydown', this.handleKeyPress)
    },
    
    handleKeyPress(event) {
      const moveSpeed = 20
      const characterSize = 80
      
      // Allow movement across the entire page
      const maxX = window.innerWidth - characterSize
      const maxY = window.innerHeight - characterSize
      
      let moved = false
      
      switch(event.code) {
        case 'KeyW':
          if (this.playerY > 0) {
            this.playerY = Math.max(0, this.playerY - moveSpeed)
            moved = true
          }
          break
        case 'KeyA':
          if (this.playerX > 0) {
            this.playerX = Math.max(0, this.playerX - moveSpeed)
            moved = true
          }
          break
        case 'KeyS':
          if (this.playerY < maxY) {
            this.playerY = Math.min(maxY, this.playerY + moveSpeed)
            moved = true
          }
          break
        case 'KeyD':
          if (this.playerX < maxX) {
            this.playerX = Math.min(maxX, this.playerX + moveSpeed)
            moved = true
          }
          break
      }
      
      // Play move sound if character actually moved
      if (moved) {
        this.playMoveSound()
      }
    },
    
    cleanupControls() {
      document.removeEventListener('keydown', this.handleKeyPress)
    },
    
    goHome() {
      this.$router.push('/')
    },
    
    playMoveSound() {
      const audio = new Audio('/src/images/sound/move-sound.mp3')
      audio.volume = 0.3
      audio.play().catch(e => console.log('Audio play failed:', e))
    }
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Pixelify+Sans:wght@400;500;600;700&display=swap');

.game-container {
  width: 100vw;
  height: 100vh;
  background: #1a1a2e;
  display: flex;
  flex-direction: column;
  font-family: 'Pixelify Sans', monospace;
  overflow: hidden;
}

.character-info {
  background: rgba(0, 0, 0, 0.8);
  border-bottom: 3px solid #00ff00;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.character-details {
  text-align: left;
}

.character-details h2 {
  color: #00ff00;
  font-size: 2rem;
  font-weight: 700;
  margin: 0;
  text-shadow: 2px 2px 0px #000000;
}

.character-details p {
  color: #ffffff;
  font-size: 1.2rem;
  margin: 0.5rem 0 0 0;
  text-shadow: 1px 1px 0px #000000;
}

.home-button {
  background: rgba(0, 255, 0, 0.2);
  border: 2px solid #00ff00;
  border-radius: 8px;
  padding: 0.75rem 1.5rem;
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.2rem;
  font-weight: 600;
  color: #00ff00;
  text-shadow: 1px 1px 0px #000000;
  cursor: pointer;
  transition: all 0.2s ease;
}

.home-button:hover {
  background: rgba(0, 255, 0, 0.4);
  transform: translateY(-2px);
  box-shadow: 0 4px 0px #00ff00;
}

.home-button:active {
  transform: translateY(1px);
  box-shadow: 0 2px 0px #00ff00;
}

.game-container {
  background-image: url('/src/images/background-box.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

.movable-character {
  position: absolute;
  width: 80px;
  height: 80px;
  transition: all 0.1s ease;
  z-index: 10;
}

.character-sprite {
  width: 100%;
  height: 100%;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}

.controls-info {
  background: rgba(0, 0, 0, 0.8);
  border-top: 3px solid #00ff00;
  padding: 1rem 2rem;
  text-align: center;
}

.controls-info p {
  color: #ffffff;
  font-size: 1.2rem;
  font-weight: 600;
  margin: 0;
  text-shadow: 1px 1px 0px #000000;
}

/* Ensure pixelated rendering */
* {
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}
</style>
