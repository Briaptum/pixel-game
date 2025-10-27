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
            src="/src/images/logo-icon.png" 
            alt="Logo Icon" 
            class="logo-icon animate-bounce-slow w-12 h-12"
          >
          <h1 class="pixel-title text-black text-4xl md:text-5xl lg:text-6xl font-bold tracking-wider">
            Anhelm
          </h1>
        </div>
      </div>
    </div>
    
    <!-- Left center navigation -->
    <nav class="absolute left-6 top-1/2 transform -translate-y-1/2 z-10">
      <div class="nav-background">
        <ul class="space-y-2 p-4">
          <li class="flex items-center">
            <img src="/src/images/right_2885956.png" alt="selected" class="w-6 h-6 mr-2">
            <router-link to="/" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">HOME</router-link>
          </li>
          <li>
            <router-link to="/play" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">PLAY</router-link>
          </li>
          <li>
            <router-link to="/options" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">OPTIONS</router-link>
          </li>
          <li>
            <router-link to="/settings" class="pixel-nav text-black hover:text-gray-600 transition-colors duration-200">SETTINGS</router-link>
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
      videoSrc: videoSrc
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

/* Ensure pixelated rendering */
* {
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
}
</style>
