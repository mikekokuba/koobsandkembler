module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    sass:
      options:
        includePaths: ["bower_components/foundation/scss"]

      dist:
        options:
          outputStyle: "compressed"

        files: [
          "css/app.css": "scss/app.scss",
          "css/style.css": "scss/style.scss"
        ]
    coffee:
      # Compile all Coffeescript files and preserve the folder hierarchy
      all:
        expand: true
        cwd: 'coffee'
        src: '**/*.coffee'
        dest: 'js/'
        rename: (dest, src)->
          # Support multiple dots in filenames
          dest + src.replace '.coffee', '.cs.js'

    watch:
      grunt:
        files: ["Gruntfile.js"]
      # Run Coffeescript compile on .coffee changes
      coffee:
        # Refer to the coffee configuration and construct the filepath
        files: 'coffee/**/*.coffee'
        tasks: 'coffee'
        options:
          # Listen for both changed and added files
          events: ['changed', 'added']

      sass:
        files: "scss/**/*.scss"
        tasks: ["sass"]

  # When 'watch' catches a file
  grunt.event.on 'watch', (action, filepath) ->
    # If the file is a coffeescript file specified in the watch.coffee config
    if grunt.file.isMatch( grunt.config('watch.coffee.files'), filepath)
      # Remove directory prefix so 'filepath' matches coffee.all.src
      filepath = filepath.replace grunt.config('coffee.all.cwd')+'/', ''
      # Pass in the filepath to coffee 'all'
      grunt.config 'coffee.all.src', filepath


  grunt.loadNpmTasks "grunt-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.registerTask "build", ["sass"]
  grunt.registerTask "default", [
    "build"
    "coffee"
    "watch"
  ]
  return