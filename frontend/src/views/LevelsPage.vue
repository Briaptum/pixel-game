<template>
  <div class="game-container">
    <!-- Character Info -->
    <div class="character-info">
      <div class="character-details">
        <h2>{{ selectedCharacter.name }}</h2>
        <p>{{ selectedCharacter.nationality }} • Age {{ selectedCharacter.age }}</p>
      </div>
      <div class="score-display">
        <span class="score-text">Stars: {{ collectedStars }}/5</span>
      </div>
      <div class="timer-display">
        <span class="timer-text">Time: {{ timeLeft }}s</span>
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

    <!-- Collectible Stars -->
    <div 
      v-for="(star, index) in stars" 
      :key="'star-' + index"
      v-show="!star.collected"
      class="star"
      :style="{ 
        left: star.x + 'px', 
        top: star.y + 'px'
      }"
    >
      <img 
        src="/src/images/sound/star.png" 
        alt="Star"
        class="star-image"
      >
    </div>

    <!-- Controls Info -->
    <div class="controls-info">
      <p>Use WASD to move around</p>
    </div>

    <!-- Congratulations Box -->
    <div v-if="allStarsCollected" class="congratulations-overlay">
      <div class="congratulations-box">
        <h2>🎉 Congratulations! 🎉</h2>
        <p>You collected all 5 stars!</p>
        <button @click="restartGame" class="restart-button">Play Again</button>
        <button @click="goHome" class="home-button">Home</button>
      </div>
    </div>

    <!-- Game Over Box -->
    <div v-if="gameOver" class="congratulations-overlay">
      <div class="game-over-box">
        <h2>⏰ Time's Up! ⏰</h2>
        <p>You collected {{ collectedStars }}/5 stars</p>
        <p>Try again to collect all stars in 30 seconds!</p>
        <button @click="restartGame" class="restart-button">Try Again</button>
        <button @click="goHome" class="home-button">Home</button>
      </div>
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
      decorations: [],
      
      // Collectible Stars
      stars: [],
      collectedStars: 0,
      
      // Timer
      timeLeft: 30,
      gameOver: false,
      timerInterval: null
    }
  },
  computed: {
    allStarsCollected() {
      return this.collectedStars >= 5
    },
    gameEnded() {
      return this.gameOver || this.allStarsCollected
    }
  },
  mounted() {
    this.setupKeyboardControls()
    this.generateDecorations()
    this.generateStars()
    this.startTimer()
  },
  beforeUnmount() {
    this.cleanupControls()
    this.clearTimer()
  },
  methods: {
    setupKeyboardControls() {
      document.addEventListener('keydown', this.handleKeyPress)
    },
    
    handleKeyPress(event) {
      // Don't allow movement if game has ended
      if (this.gameEnded) return
      
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
        this.checkStarCollection()
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
        const decorationSize = decoration.type === 'tree' ? 40 : 25
        const decorationX = decoration.x
        const decorationY = decoration.y
        
        // Check if rectangles overlap with some padding
        const padding = 3
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
        const decorationSize = decoration.type === 'tree' ? 40 : 25
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
    },
    
    generateStars() {
      const stars = []
      const viewportWidth = window.innerWidth
      const viewportHeight = window.innerHeight
      
      // Generate exactly 5 stars
      for (let i = 0; i < 5; i++) {
        let attempts = 0
        let validPosition = false
        let x, y
        
        // Try to find a valid position for the star
        while (!validPosition && attempts < 50) {
          x = Math.random() * (viewportWidth - 40)
          y = Math.random() * (viewportHeight - 200)
          
          // Check collision with decorations and other stars
          validPosition = !this.checkStarCollision(x, y, 30, stars)
        }
        
        if (validPosition) {
          stars.push({
            x: x,
            y: y,
            collected: false
          })
        }
      }
      
      this.stars = stars
    },
    
    checkStarCollision(x, y, size, existingStars) {
      // Check collision with decorations
      for (const decoration of this.decorations) {
        const decorationSize = decoration.type === 'tree' ? 40 : 25
        const decorationX = decoration.x
        const decorationY = decoration.y
        
        if (x < decorationX + decorationSize &&
            x + size > decorationX &&
            y < decorationY + decorationSize &&
            y + size > decorationY) {
          return true
        }
      }
      
      // Check collision with other stars
      for (const star of existingStars) {
        if (x < star.x + 30 &&
            x + size > star.x &&
            y < star.y + 30 &&
            y + size > star.y) {
          return true
        }
      }
      
      return false
    },
    
    checkStarCollection() {
      const heroSize = 80
      const heroX = this.playerX
      const heroY = this.playerY
      
      for (let i = 0; i < this.stars.length; i++) {
        const star = this.stars[i]
        if (!star.collected) {
          const starSize = 30
          
          // Check if hero is touching the star
          if (heroX < star.x + starSize &&
              heroX + heroSize > star.x &&
              heroY < star.y + starSize &&
              heroY + heroSize > star.y) {
            
            // Collect the star
            star.collected = true
            this.collectedStars++
            this.playStarSound()
            
            // Check if all stars are collected
            if (this.collectedStars >= 5) {
              this.clearTimer()
            }
          }
        }
      }
    },
    
    playStarSound() {
      const audio = new Audio('/src/images/sound/success.mp3')
      audio.volume = 0.5
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    
    restartGame() {
      this.collectedStars = 0
      this.stars.forEach(star => {
        star.collected = false
      })
      this.playerX = 400
      this.playerY = 300
      this.gameOver = false
      this.timeLeft = 30
      this.clearTimer()
      this.startTimer()
    },
    
    startTimer() {
      this.timerInterval = setInterval(() => {
        if (this.timeLeft > 0) {
          this.timeLeft--
          
          // Play warning sounds
          if (this.timeLeft === 10) {
            this.playWarningSound()
          } else if (this.timeLeft <= 5 && this.timeLeft > 0) {
            this.playTickSound()
          }
        } else {
          this.endGame()
        }
      }, 1000)
    },
    
    clearTimer() {
      if (this.timerInterval) {
        clearInterval(this.timerInterval)
        this.timerInterval = null
      }
    },
    
    endGame() {
      this.gameOver = true
      this.clearTimer()
      this.playGameOverSound()
    },
    
    playWarningSound() {
      const audio = new Audio('/src/images/sound/interface-soft-click-131438.mp3')
      audio.volume = 0.4
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    
    playTickSound() {
      const audio = new Audio('/src/images/sound/ui-button-click-4-284571.mp3')
      audio.volume = 0.3
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    
    playGameOverSound() {
      const audio = new Audio('/src/images/sound/fail-234710.mp3')
      audio.volume = 0.6
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

.score-display {
  background: rgba(0, 255, 0, 0.2);
  border: 2px solid #00ff00;
  border-radius: 8px;
  padding: 0.5rem 1rem;
}

.score-text {
  color: #00ff00;
  font-size: 1.2rem;
  font-weight: 600;
  text-shadow: 1px 1px 0px #000000;
}

.timer-display {
  background: rgba(255, 165, 0, 0.2);
  border: 2px solid #ffa500;
  border-radius: 8px;
  padding: 0.5rem 1rem;
}

.timer-text {
  color: #ffa500;
  font-size: 1.2rem;
  font-weight: 600;
  text-shadow: 1px 1px 0px #000000;
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

/* Stars */
.star {
  position: absolute;
  width: 30px;
  height: 30px;
  z-index: 5;
  pointer-events: none;
  animation: twinkle 2s ease-in-out infinite alternate;
}

.star-image {
  width: 100%;
  height: 100%;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}

@keyframes twinkle {
  0% {
    opacity: 0.7;
    transform: scale(1);
  }
  100% {
    opacity: 1;
    transform: scale(1.1);
  }
}

/* Congratulations Box */
.congratulations-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.congratulations-box {
  background: linear-gradient(135deg, #1a1a2e, #16213e);
  border: 3px solid #00ff00;
  border-radius: 15px;
  padding: 2rem;
  text-align: center;
  box-shadow: 0 0 30px rgba(0, 255, 0, 0.5);
  animation: celebration 0.5s ease-out;
}

.congratulations-box h2 {
  color: #00ff00;
  font-size: 2.5rem;
  font-weight: 700;
  margin: 0 0 1rem 0;
  text-shadow: 2px 2px 0px #000000;
}

.congratulations-box p {
  color: #ffffff;
  font-size: 1.5rem;
  margin: 0 0 2rem 0;
  text-shadow: 1px 1px 0px #000000;
}

.game-over-box {
  background: linear-gradient(135deg, #2e1a1a, #3e1616);
  border: 3px solid #ff6b6b;
  border-radius: 15px;
  padding: 2rem;
  text-align: center;
  box-shadow: 0 0 30px rgba(255, 107, 107, 0.5);
  animation: celebration 0.5s ease-out;
}

.game-over-box h2 {
  color: #ff6b6b;
  font-size: 2.5rem;
  font-weight: 700;
  margin: 0 0 1rem 0;
  text-shadow: 2px 2px 0px #000000;
}

.game-over-box p {
  color: #ffffff;
  font-size: 1.2rem;
  margin: 0 0 1rem 0;
  text-shadow: 1px 1px 0px #000000;
}

.restart-button {
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
  margin-right: 1rem;
}

.restart-button:hover {
  background: rgba(0, 255, 0, 0.4);
  transform: translateY(-2px);
  box-shadow: 0 4px 0px #00ff00;
}

@keyframes celebration {
  0% {
    transform: scale(0.5);
    opacity: 0;
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

/* Ensure pixelated rendering */
* {
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}
</style>
