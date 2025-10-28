<template>
  <div class="min-h-screen relative flex justify-center pt-20 bg-black">
    <!-- Full-screen video background -->
    <video 
      autoplay 
      muted 
      loop 
      playsinline
      class="absolute inset-0 w-full h-full object-cover z-0"
    >
      <source :src="videoSrc" type="video/mp4">
    </video>
    
    <!-- Text overlay -->
    <div class="text-center relative z-10">
      <div class="title-background">
        <h1 class="pixel-title text-black text-4xl md:text-5xl lg:text-6xl font-bold tracking-wider">
          PLAY
        </h1>
      </div>
    </div>
    
    <!-- Level Selection Box -->
    <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 z-10 mt-24">
      <div class="level-selection-box">
        <h2 class="level-selection-title">Choose Level</h2>
        
        <!-- Level List - Horizontal Layout -->
        <div class="level-list-horizontal">
          <div v-for="(level, index) in levels" :key="index" 
               :class="['level-item-simple', { selected: selectedLevelIndex === index }]"
               @click="selectLevel(index)">
            <div class="level-number-simple">{{ level.number }}</div>
            <div class="level-name-simple">{{ level.name }}</div>
            <div v-if="selectedLevelIndex === index" class="level-selected-indicator">
              <img src="/src/images/right_2885956.png" alt="Selected" class="selected-icon">
            </div>
          </div>
        </div>
        
        <!-- Start Button -->
        <div class="start-button-section">
          <button @click="startLevel" class="start-button" :disabled="selectedLevelIndex === null">
            Start Level {{ selectedLevelIndex !== null ? levels[selectedLevelIndex].number : '' }}
          </button>
        </div>
      </div>
    </div>
    
    <!-- Left center navigation -->
    <nav class="absolute left-6 top-1/2 transform -translate-y-1/2 z-10">
      <div class="nav-background">
        <ul class="space-y-2 p-4">
          <li>
            <router-link to="/" @click="playSelectSound" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">HOME</router-link>
          </li>
          <li class="flex items-center">
            <img src="/src/images/right_2885956.png" alt="selected" class="w-6 h-6 mr-2">
            <router-link to="/play" @click="playSelectSound" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">PLAY</router-link>
          </li>
          <li>
            <router-link to="/options" @click="playSelectSound" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">OPTIONS</router-link>
          </li>
          <li>
            <router-link to="/settings" @click="playSelectSound" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">SETTINGS</router-link>
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>

<script>
import videoSrc from '../video/0_Pixel_Art_Night_3840x2160.mp4?url'

export default {
  name: 'PlayPage',
  data() {
    return {
      videoSrc: videoSrc,
      selectedLevelIndex: null,
      levels: [
        {
          number: 1,
          name: 'Forest Beginnings',
          description: 'Start your adventure in the mystical forest',
          difficulty: [1, 2, 3] // Array for v-for loop
        },
        {
          number: 2,
          name: 'Mountain Pass',
          description: 'Navigate through treacherous mountain paths',
          difficulty: [1, 2, 3, 4]
        },
        {
          number: 3,
          name: 'Desert Oasis',
          description: 'Survive the scorching desert sands',
          difficulty: [1, 2, 3, 4, 5]
        },
        {
          number: 4,
          name: 'Crystal Caves',
          description: 'Explore the mysterious crystal formations',
          difficulty: [1, 2, 3, 4, 5, 6]
        },
        {
          number: 5,
          name: 'Sky Temple',
          description: 'Ascend to the floating temple in the clouds',
          difficulty: [1, 2, 3, 4, 5, 6, 7]
        }
      ]
    }
  },
  methods: {
    playSelectSound() {
      const audio = new Audio('/src/images/sound/select-sound-121244.mp3')
      audio.volume = 0.5
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    playClickSound() {
      const audio = new Audio('/src/images/sound/ui-button-click-4-284571.mp3')
      audio.volume = 0.3
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    playSuccessSound() {
      const audio = new Audio('/src/images/sound/success.mp3')
      audio.volume = 0.5
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    selectLevel(index) {
      this.selectedLevelIndex = index
      this.playClickSound()
    },
    startLevel() {
      if (this.selectedLevelIndex !== null) {
        this.playSuccessSound()
        // Navigate to the game level page
        console.log(`Starting Level ${this.levels[this.selectedLevelIndex].number}: ${this.levels[this.selectedLevelIndex].name}`)
        this.$router.push('/levels')
      }
    }
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Pixelify+Sans:wght@400;500;600;700&display=swap');

.pixel-title {
  font-family: 'Pixelify Sans', monospace;
  text-shadow: 2px 2px 0px #ffffff;
  animation: glitchTitle 15s ease-in-out infinite;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}

.title-background {
  background-color: rgba(255, 255, 255, 0.9);
  border: 3px solid #000000;
  border-radius: 8px;
  box-shadow: 4px 4px 0px #000000;
  padding: 1rem 2rem;
  display: inline-block;
}

.pixel-nav {
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.2rem;
  font-weight: 600;
  text-decoration: none;
  text-shadow: 2px 2px 0px #ffffff;
  display: block;
  padding: 0.5rem 0;
  animation: glitchNav 20s ease-in-out infinite;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}

.nav-background {
  background-color: rgba(255, 255, 255, 0.9);
  border: 3px solid #000000;
  border-radius: 8px;
  box-shadow: 4px 4px 0px #000000;
}

/* Level Selection Styles */
.level-selection-box {
  background-color: rgba(255, 255, 255, 0.9);
  border: 3px solid #000000;
  border-radius: 8px;
  box-shadow: 4px 4px 0px #000000;
  padding: 1rem;
  width: 700px;
  max-width: 90vw;
}

.level-selection-title {
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.4rem;
  font-weight: 600;
  color: #000000;
  text-shadow: 1px 1px 0px #ffffff;
  margin: 0 0 1rem 0;
  text-align: center;
}

.level-list-horizontal {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
  justify-content: center;
  flex-wrap: wrap;
}

.level-item-simple {
  background-color: rgba(255, 255, 255, 0.7);
  border: 2px solid #000000;
  border-radius: 6px;
  padding: 0.75rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.25rem;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
  min-width: 100px;
  flex: 1;
  max-width: 120px;
}

.level-item-simple:hover {
  background-color: rgba(255, 255, 255, 0.9);
  transform: translateY(-1px);
  box-shadow: 2px 2px 0px #000000;
}

.level-item-simple.selected {
  background-color: rgba(255, 255, 255, 1);
  border: 3px solid #000000;
  box-shadow: 3px 3px 0px #000000;
}

.level-number-simple {
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.5rem;
  font-weight: 700;
  color: #000000;
  text-shadow: 1px 1px 0px #ffffff;
}

.level-name-simple {
  font-family: 'Pixelify Sans', monospace;
  font-size: 0.9rem;
  font-weight: 600;
  color: #000000;
  text-shadow: 1px 1px 0px #ffffff;
  text-align: center;
  line-height: 1.1;
}

.level-selected-indicator {
  position: absolute;
  top: -5px;
  right: -5px;
}

.selected-icon {
  width: 1rem;
  height: 1rem;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}

/* Start Button */
.start-button-section {
  display: flex;
  justify-content: center;
}

.start-button {
  background-color: rgba(255, 255, 255, 0.9);
  border: 3px solid #000000;
  border-radius: 8px;
  padding: 0.75rem 1.5rem;
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.2rem;
  font-weight: 600;
  color: #000000;
  text-shadow: 1px 1px 0px #ffffff;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 3px 3px 0px #000000;
}

.start-button:hover:not(:disabled) {
  background-color: rgba(255, 255, 255, 1);
  transform: translateY(-2px);
  box-shadow: 4px 4px 0px #000000;
}

.start-button:active:not(:disabled) {
  transform: translateY(1px);
  box-shadow: 2px 2px 0px #000000;
}

.start-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  background-color: rgba(255, 255, 255, 0.5);
}

@keyframes glitchTitle {
  0%, 85%, 100% {
    transform: translate(0);
    filter: hue-rotate(0deg);
  }
  5% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(90deg);
  }
  10% {
    transform: translate(4px, -4px);
    filter: hue-rotate(180deg);
  }
  15% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(270deg);
  }
  20% {
    transform: translate(4px, -4px);
    filter: hue-rotate(360deg);
  }
  25% {
    transform: translate(-8px, 8px);
    filter: hue-rotate(45deg);
  }
  30% {
    transform: translate(8px, -8px);
    filter: hue-rotate(135deg);
  }
  35% {
    transform: translate(-4px, 8px);
    filter: hue-rotate(225deg);
  }
  40% {
    transform: translate(8px, -4px);
    filter: hue-rotate(315deg);
  }
  45% {
    transform: translate(-8px, 4px);
    filter: hue-rotate(60deg);
  }
  50% {
    transform: translate(4px, -8px);
    filter: hue-rotate(120deg);
  }
  55% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(180deg);
  }
  60% {
    transform: translate(4px, -4px);
    filter: hue-rotate(240deg);
  }
  65% {
    transform: translate(-8px, 8px);
    filter: hue-rotate(300deg);
  }
  70% {
    transform: translate(8px, -8px);
    filter: hue-rotate(360deg);
  }
  75% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(30deg);
  }
  80% {
    transform: translate(4px, -4px);
    filter: hue-rotate(90deg);
  }
}

@keyframes glitchNav {
  0%, 90%, 100% {
    transform: translate(0);
    filter: hue-rotate(0deg);
  }
  3% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(60deg);
  }
  6% {
    transform: translate(2px, -2px);
    filter: hue-rotate(120deg);
  }
  9% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(180deg);
  }
  12% {
    transform: translate(2px, -2px);
    filter: hue-rotate(240deg);
  }
  15% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(300deg);
  }
  18% {
    transform: translate(4px, -4px);
    filter: hue-rotate(360deg);
  }
  21% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(30deg);
  }
  24% {
    transform: translate(2px, -2px);
    filter: hue-rotate(90deg);
  }
  27% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(150deg);
  }
  30% {
    transform: translate(2px, -2px);
    filter: hue-rotate(210deg);
  }
  33% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(270deg);
  }
  36% {
    transform: translate(4px, -4px);
    filter: hue-rotate(330deg);
  }
  39% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(45deg);
  }
  42% {
    transform: translate(2px, -2px);
    filter: hue-rotate(105deg);
  }
  45% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(165deg);
  }
  48% {
    transform: translate(2px, -2px);
    filter: hue-rotate(225deg);
  }
  51% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(285deg);
  }
  54% {
    transform: translate(4px, -4px);
    filter: hue-rotate(345deg);
  }
  57% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(15deg);
  }
  60% {
    transform: translate(2px, -2px);
    filter: hue-rotate(75deg);
  }
  63% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(135deg);
  }
  66% {
    transform: translate(2px, -2px);
    filter: hue-rotate(195deg);
  }
  69% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(255deg);
  }
  72% {
    transform: translate(4px, -4px);
    filter: hue-rotate(315deg);
  }
  75% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(0deg);
  }
  78% {
    transform: translate(2px, -2px);
    filter: hue-rotate(60deg);
  }
  81% {
    transform: translate(-2px, 2px);
    filter: hue-rotate(120deg);
  }
  84% {
    transform: translate(2px, -2px);
    filter: hue-rotate(180deg);
  }
  87% {
    transform: translate(-4px, 4px);
    filter: hue-rotate(240deg);
  }
}

/* Ensure pixelated rendering */
* {
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}
</style>
