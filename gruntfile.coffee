module.exports = (grunt) ->
  grunt.initConfig({
    pkg: grunt.file.readJSON 'package.json'
    #Build app.css with foundation
    sass:
      dist:
        options:
          loadPath: ['node_modules/foundation-sites/scss']
          sourcemap: 'none'
        files:
          'web/css/app.css': 'app/sass/app.scss'
    #Copy images, fonts, or any other asset excluding sass files
    copy:
      style_files:
        files: [
          expand: true
          cwd: 'app/sass'
          src: ['**','!*.scss']
          dest: 'web/css/'
          ]
    #Build js file with required libraries
    uglify:
      options:
        manage: false
      build:
        files:
          'web/js/modernizr.js': 'node_modules/foundation-sites/vendor/modernizr/modernizr.js'
          'web/js/build.js': [
            'node_modules/jquery/dist/jquery.min.js',
            'node_modules/what-input/dist/what-input.min.js',
            'node_modules/foundation-sites/dist/js/foundation.js'
          ]
    coffee:
      compile:
        options:
          bare: true
        files:
          'web/js/app.js': 'app/coffee/app.coffee'
    watch:
      #Update styles when yarn is updated or
      foundation:
        files: ['node_modules/foundation-sites/scss/**', 'app/sass/*']
        tasks: ['sass','copy:style_files']
      style_assets:
        files: ['app/sass/*', '!*.scss']
        tasks: []
      appjs:
        files: ['app/coffee/app.coffee']
        tasks: ['coffee']
      scripts:
        files: [
          'node_modules/jquery/dist/jquery.min.js',
          'node_modules/what-input/dist/what-input.min.js',
          'node_modules/foundation-sites/dist/js/foundation.min.js'
        ]
        tasks: ['uglify']
  })

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  return