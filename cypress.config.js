const { defineConfig } = require('cypress')

module.exports = defineConfig({
  // setupNodeEvents can be defined in either
  // the e2e or component configuration
  e2e: {
    setupNodeEvents(on, config) {
      on('before:browser:launch', (browser = {}, launchOptions) => {
        /* ... */
      })
    },


    // OPTIMIZE: Error supportFile missing when not set to false
    supportFile: false,
  },
  screenshotsFolder: "tmp/cypress_screenshots",
  videosFolder: "tmp/cypress_videos",
  trashAssetsBeforeRuns: false
})
