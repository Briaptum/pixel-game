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

    <!-- Random Decorations -->
    <div 
      v-for="(decoration, index) in decorations" 
      :key="index"
      class="decoration"
      :class="decoration.type"
      :style="{ 
        left: decoration.x + 'px', 
        top: decoration.y + 'px'
      }"
    >
      <img 
        :src="decoration.type === 'tree' ? '/src/images/sound/tree.png' : '/src/images/sound/daisy.png'" 
        :alt="decoration.type === 'tree' ? 'Tree' : 'Daisy'"
        class="decoration-image"
      >
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
      playerY: 300,
      
      // Random Decorations
      decorations: []
    }
  },
  mounted() {
    this.setupKeyboardControls()
    this.generateDecorations()
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
      
      let newX = this.playerX
      let newY = this.playerY
      let moved = false
      
      switch(event.code) {
        case 'KeyW':
          if (this.playerY > 0) {
            newY = Math.max(0, this.playerY - moveSpeed)
            moved = true
          }
          break
        case 'KeyA':
          if (this.playerX > 0) {
            newX = Math.max(0, this.playerX - moveSpeed)
            moved = true
          }
          break
        case 'KeyS':
          if (this.playerY < maxY) {
            newY = Math.min(maxY, this.playerY + moveSpeed)
            moved = true
          }
          break
        case 'KeyD':
          if (this.playerX < maxX) {
            newX = Math.min(maxX, this.playerX + moveSpeed)
            moved = true
          }
          break
      }
      
      // Check for collision with decorations before moving
      if (moved && !this.checkHeroCollision(newX, newY, characterSize)) {
        this.playerX = newX
        this.playerY = newY
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
    },
    
    generateDecorations() {
      const decorations = []
      const viewportWidth = window.innerWidth
      const viewportHeight = window.innerHeight
      
      // Generate 8-12 trees (bigger decorations)
      const treeCount = Math.floor(Math.random() * 5) + 8
      for (let i = 0; i < treeCount; i++) {
        let attempts = 0
        let validPosition = false
        let x, y
        
        // Try to find a valid position for the tree
        while (!validPosition && attempts < 50) {
          x = Math.random() * (viewportWidth - 120)
          y = Math.random() * (viewportHeight - 200)
          
          // Check collision with existing decorations
          validPosition = !this.checkCollision(x, y, 100, decorations)
          attempts++
        }
        
        if (validPosition) {
          decorations.push({
            type: 'tree',
            x: x,
            y: y
          })
        }
      }
      
      // Generate 15-20 daisies (smaller decorations)
      const daisyCount = Math.floor(Math.random() * 6) + 15
      for (let i = 0; i < daisyCount; i++) {
        let attempts = 0
        let validPosition = false
        let x, y
        
        // Try to find a valid position for the daisy
        while (!validPosition && attempts < 50) {
          x = Math.random() * (viewportWidth - 60)
          y = Math.random() * (viewportHeight - 200)
          
          // Check collision with existing decorations
          validPosition = !this.checkCollision(x, y, 50, decorations)
          attempts++
        }
        
        if (validPosition) {
          decorations.push({
            type: 'daisy',
            x: x,
            y: y
          })
        }
      }
      
      this.decorations = decorations
    },
    
    checkCollision(x, y, size, existingDecorations) {
      for (const decoration of existingDecorations) {
        const decorationSize = decoration.type === 'tree' ? 60 : 30
        const decorationX = decoration.x
        const decorationY = decoration.y
        
        // Check if rectangles overlap with some padding
        const padding = 5
        if (x < decorationX + decorationSize + padding &&
            x + size + padding > decorationX &&
            y < decorationY + decorationSize + padding &&
            y + size + padding > decorationY) {
          return true
        }
      }
      return false
    },
    
    checkHeroCollision(newX, newY, heroSize) {
      for (const decoration of this.decorations) {
        const decorationSize = decoration.type === 'tree' ? 60 : 30
        const decorationX = decoration.x
        const decorationY = decoration.y
        
        // Check if hero would collide with decoration
        if (newX < decorationX + decorationSize &&
            newX + heroSize > decorationX &&
            newY < decorationY + decorationSize &&
            newY + heroSize > decorationY) {
          return true
        }
      }
      return false
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

/* Decorations */
.decoration {
  position: absolute;
  z-index: 1;
  pointer-events: none;
}

.decoration.tree {
  width: 100px;
  height: 100px;
}

.decoration.daisy {
  width: 50px;
  height: 50px;
}

.decoration-image {
  width: 100%;
  height: 100%;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
  opacity: 0.8;
}

/* Ensure pixelated rendering */
* {
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}
</style>
