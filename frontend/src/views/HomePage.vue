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
        <div class="flex items-center justify-center gap-4">
          <img 
            src="/src/icons/logo-icon.png" 
            alt="Logo Icon" 
            class="logo-icon animate-bounce-slow w-12 h-12"
          >
          <h1 class="pixel-title text-black text-4xl md:text-5xl lg:text-6xl font-bold tracking-wider">
            Anhelm Game
          </h1>
        </div>
      </div>
    </div>
    
    <!-- Character box - positioned in center with spacing from header -->
    <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 z-10 mt-20">
      <div class="character-box">
        <!-- Navigation buttons -->
        <div class="character-navigation">
          <button @click="previousCharacter" class="nav-button prev-button" :disabled="currentCharacterIndex === 0">
            <span class="nav-arrow left-arrow">‹</span>
          </button>
          <button @click="nextCharacter" class="nav-button next-button" :disabled="currentCharacterIndex === characters.length - 1">
            <span class="nav-arrow right-arrow">›</span>
          </button>
        </div>
        
        <div class="character-content">
          <div class="character-info">
            <div class="character-details">
              <div class="detail-row">
                <span class="detail-label">Name:</span>
                <span class="detail-value character-name">{{ currentCharacter.name }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Nationality:</span>
                <span class="detail-value">{{ currentCharacter.nationality }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Age:</span>
                <span class="detail-value">{{ currentCharacter.age }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Health:</span>
                <div class="health-display">
                  <img v-for="heart in currentCharacter.health" :key="heart" src="/src/icons/heart.png" alt="Health" class="health-icon">
                </div>
              </div>
              <div class="detail-row backstory-row">
                <span class="detail-label">Backstory:</span>
                <span class="detail-value backstory-text">{{ currentCharacter.backstory }}</span>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Character indicator dots -->
        <div class="character-indicators">
          <span v-for="(character, index) in characters" :key="index" 
                :class="['indicator-dot', { active: index === currentCharacterIndex }]"
                @click="selectCharacter(index)">
          </span>
        </div>
        
        <!-- Choose Character Button -->
        <div class="choose-character-section">
          <button @click="chooseCharacter" class="choose-character-btn">
            Choose Character
          </button>
        </div>
      </div>
    </div>
    
    <!-- Character Selection Confirmation Modal -->
    <div v-if="showConfirmation" class="confirmation-overlay" @click="closeConfirmation">
      <div class="confirmation-box" @click.stop>
        <div class="confirmation-content">
          <div class="confirmation-icon">✨</div>
          <h3 class="confirmation-title">Character Selected!</h3>
          <p class="confirmation-message">
            You have chosen <strong>{{ currentCharacter.name }}</strong>!
          </p>
          <div class="confirmation-character-info">
            <p>{{ currentCharacter.nationality }} • Age {{ currentCharacter.age }}</p>
            <p class="confirmation-backstory">{{ currentCharacter.backstory }}</p>
          </div>
          <button @click="closeConfirmation" class="confirmation-close-btn">
            Awesome! 🎮
          </button>
        </div>
      </div>
    </div>
    
    <!-- Left center navigation -->
    <nav class="absolute left-6 top-1/2 transform -translate-y-1/2 z-10">
      <div class="nav-background">
        <ul class="space-y-2 p-4">
          <li class="flex items-center">
            <img src="/src/icons/right.png" alt="selected" class="w-6 h-6 mr-2">
            <router-link to="/" @click="playSelectSound" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">HOME</router-link>
          </li>
          <li>
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
  name: 'HomePage',
  data() {
    return {
      videoSrc: videoSrc,
      currentCharacterIndex: 0,
      showConfirmation: false,
      characters: [
        {
          name: 'Alex Thunderstrike',
          nationality: 'Nordic',
          age: 24,
          health: [1, 2, 3, 4, 5], // Array for v-for loop
          backstory: 'A skilled warrior from the frozen north, trained in ancient combat arts and blessed with lightning magic.'
        },
        {
          name: 'Maya Shadowweaver',
          nationality: 'Desert Nomad',
          age: 28,
          health: [1, 2, 3, 4],
          backstory: 'A mysterious sorceress from the shifting sands, master of shadow magic and ancient rituals.'
        },
        {
          name: 'Finn Ironbeard',
          nationality: 'Mountain Dwarf',
          age: 45,
          health: [1, 2, 3, 4, 5, 6],
          backstory: 'A legendary blacksmith and warrior from the deep mountains, forged in fire and tempered by battle.'
        },
        {
          name: 'Luna Stardancer',
          nationality: 'Forest Elf',
          age: 156,
          health: [1, 2, 3],
          backstory: 'An ancient elf druid who communes with nature and wields the power of the stars and moon.'
        },
        {
          name: 'Rex Stormbreaker',
          nationality: 'Coastal Barbarian',
          age: 32,
          health: [1, 2, 3, 4, 5],
          backstory: 'A fierce warrior from the stormy coasts, blessed by the sea gods and wielding the power of hurricanes.'
        }
      ]
    }
  },
  computed: {
    currentCharacter() {
      return this.characters[this.currentCharacterIndex]
    }
  },
  methods: {
    playSelectSound() {
      const audio = new Audio('/src/sound/menu-click-89198.mp3')
      audio.volume = 0.5
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    playClickSound() {
      const audio = new Audio('/src/sound/pop.mp3')
      audio.volume = 0.3
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    playSuccessSound() {
      const audio = new Audio('/src/sound/success.mp3')
      audio.volume = 0.5
      audio.play().catch(e => console.log('Audio play failed:', e))
    },
    nextCharacter() {
      if (this.currentCharacterIndex < this.characters.length - 1) {
        this.currentCharacterIndex++
        this.playClickSound()
      }
    },
    previousCharacter() {
      if (this.currentCharacterIndex > 0) {
        this.currentCharacterIndex--
        this.playClickSound()
      }
    },
    selectCharacter(index) {
      this.currentCharacterIndex = index
      this.playClickSound()
    },
    chooseCharacter() {
      this.showConfirmation = true
      this.playSuccessSound()
    },
    closeConfirmation() {
      this.showConfirmation = false
      this.playClickSound()
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

.logo-icon {
  width: 2.5rem;
  height: 2.5rem;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
  animation: logoFloat 3s ease-in-out infinite;
}

.character-box {
  background-color: #ffffff;
  border: 2px solid #000000;
  border-radius: 4px;
  padding: 1rem;
  display: inline-block;
  min-width: 320px;
  max-width: 380px;
  position: relative;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.character-content {
  display: flex;
  align-items: flex-start;
  gap: 1.5rem;
}

.character-image {
  width: 5rem;
  height: 5rem;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}

.character-info {
  flex: 1;
}

.character-name {
  font-family: 'Pixelify Sans', monospace;
  font-size: 2rem;
  font-weight: 800;
  color: #000000;
}

.character-details {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.detail-row {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.25rem 0;
}

.backstory-row {
  flex-direction: column;
  align-items: flex-start;
  gap: 0.5rem;
  padding: 0.5rem 0;
  border-top: 1px solid #e0e0e0;
  margin-top: 0.5rem;
}

.detail-label {
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.4rem;
  font-weight: 700;
  color: #000000;
  min-width: 120px;
}

.detail-value {
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.4rem;
  color: #000000;
  font-weight: 600;
}

.backstory-text {
  font-size: 1.1rem;
  line-height: 1.4;
  max-width: 250px;
  color: #000000;
  font-weight: 500;
}

.health-display {
  display: flex;
  gap: 2px;
}

.health-icon {
  width: 1rem;
  height: 1rem;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
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

@keyframes logoFloat {
  0%, 100% {
    transform: translateY(0px) rotate(0deg);
  }
  25% {
    transform: translateY(-8px) rotate(5deg);
  }
  50% {
    transform: translateY(-4px) rotate(0deg);
  }
  75% {
    transform: translateY(-8px) rotate(-5deg);
  }
}

/* Character Navigation Styles */
.character-navigation {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: calc(100% + 100px);
  left: -50px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  pointer-events: none;
}

.nav-button {
  background-color: rgba(255, 255, 255, 0.9);
  border: 2px solid #000000;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  pointer-events: all;
  transition: all 0.2s ease;
  box-shadow: 2px 2px 0px #000000;
}

.nav-button:hover:not(:disabled) {
  background-color: rgba(255, 255, 255, 1);
  transform: translateY(-1px);
  box-shadow: 3px 3px 0px #000000;
}

.nav-button:active:not(:disabled) {
  transform: translateY(1px);
  box-shadow: 1px 1px 0px #000000;
}

.nav-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.prev-button {
  margin-left: 0;
}

.next-button {
  margin-right: 0;
}

.nav-arrow {
  font-family: 'Pixelify Sans', monospace;
  font-size: 24px;
  font-weight: bold;
  color: #000000;
  text-shadow: 1px 1px 0px #ffffff;
  line-height: 1;
}

/* Character Indicators */
.character-indicators {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 1rem;
}

.indicator-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background-color: rgba(0, 0, 0, 0.3);
  border: 2px solid #000000;
  cursor: pointer;
  transition: all 0.2s ease;
}

.indicator-dot:hover {
  background-color: rgba(0, 0, 0, 0.6);
  transform: scale(1.1);
}

.indicator-dot.active {
  background-color: #000000;
  transform: scale(1.2);
}

/* Choose Character Button */
.choose-character-section {
  display: flex;
  justify-content: center;
  margin-top: 1rem;
}

.choose-character-btn {
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

.choose-character-btn:hover {
  background-color: rgba(255, 255, 255, 1);
  transform: translateY(-2px);
  box-shadow: 4px 4px 0px #000000;
}

.choose-character-btn:active {
  transform: translateY(1px);
  box-shadow: 2px 2px 0px #000000;
}

/* Confirmation Modal */
.confirmation-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  animation: fadeIn 0.3s ease-out;
}

.confirmation-box {
  background-color: rgba(255, 255, 255, 0.95);
  border: 4px solid #000000;
  border-radius: 12px;
  box-shadow: 6px 6px 0px #000000;
  padding: 2rem;
  max-width: 500px;
  width: 90%;
  animation: slideIn 0.3s ease-out;
}

.confirmation-content {
  text-align: center;
}

.confirmation-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  animation: bounce 0.6s ease-in-out;
}

.confirmation-title {
  font-family: 'Pixelify Sans', monospace;
  font-size: 2rem;
  font-weight: 700;
  color: #000000;
  text-shadow: 2px 2px 0px #ffffff;
  margin: 0 0 1rem 0;
}

.confirmation-message {
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.3rem;
  color: #333333;
  text-shadow: 1px 1px 0px #ffffff;
  margin: 0 0 1.5rem 0;
}

.confirmation-character-info {
  background-color: rgba(0, 0, 0, 0.1);
  border: 2px solid #000000;
  border-radius: 8px;
  padding: 1rem;
  margin: 1rem 0;
}

.confirmation-character-info p {
  font-family: 'Pixelify Sans', monospace;
  font-size: 1.1rem;
  color: #333333;
  text-shadow: 1px 1px 0px #ffffff;
  margin: 0.5rem 0;
}

.confirmation-backstory {
  font-size: 1rem !important;
  line-height: 1.4;
  font-style: italic;
}

.confirmation-close-btn {
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
  margin-top: 1rem;
}

.confirmation-close-btn:hover {
  background-color: rgba(255, 255, 255, 1);
  transform: translateY(-2px);
  box-shadow: 4px 4px 0px #000000;
}

.confirmation-close-btn:active {
  transform: translateY(1px);
  box-shadow: 2px 2px 0px #000000;
}

/* Animations */
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-50px) scale(0.8);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    transform: translateY(0);
  }
  40% {
    transform: translateY(-10px);
  }
  60% {
    transform: translateY(-5px);
  }
}

/* Ensure pixelated rendering */
* {
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}
</style>
