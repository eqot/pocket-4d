gulp = require 'gulp'

$ = require('gulp-load-plugins')()

name = require('./package.json').name

paths =
  scripts: ['*.coffee', '!gulpfile.coffee']
  styles: ['*.less']

gulp.task 'scripts', ->
  return gulp.src paths.scripts
    .pipe $.plumber()
    .pipe $.coffee({bare: true})
    .pipe gulp.dest('.tmp/' + name)

gulp.task 'styles', ->
  return gulp.src paths.styles
    .pipe $.plumber()
    .pipe $.less()
    .pipe $.autoprefixer('last 1 version')
    .pipe gulp.dest('.tmp/' + name)

gulp.task 'clean', require('del').bind null, ['.tmp', 'dist']

gulp.task 'connect', ->
  connect = require 'connect'
  serveStatic = require 'serve-static'
  serveIndex = require 'serve-index'

  app = connect()
    .use require('connect-livereload')({port: 35729})
    .use serveStatic('../')
    .use serveStatic('.tmp')
    .use '/bower_components', serveStatic('bower_components')
    .use serveIndex('../')

  require('http').createServer app
    .listen 8080
    .on 'listening', ->
      console.log 'Started connect web server on http://localhost:8080'

gulp.task 'serve', ->
  require('opn')('http://localhost:8080/' + name + '/demo.html')

gulp.task 'watch', ['scripts', 'styles', 'connect', 'serve'], ->
  $.livereload.listen()

  gulp.watch([
    '*.html',
    '.tmp/**/*.js',
    '.tmp/**/*.css'
  ]).on 'change', $.livereload.changed

  gulp.watch paths.scripts, ['scripts']
  gulp.watch paths.styles, ['styles']

gulp.task 'symlink', ->
  gulp.src name + '.html'
    .pipe $.symlink('.tmp/' + name + '/' + name + '.html')

  return gulp.src '../bower_components/polymer/'
    .pipe $.symlink('.tmp/bower_components/polymer')

gulp.task 'compile', ['scripts', 'styles', 'symlink'], ->
  return gulp.src '.tmp/' + name + '/' + name + '.html'
    .pipe $.vulcanize({dest: 'dist', inline: true})
    .pipe gulp.dest('dist')

gulp.task 'build', ['clean'], ->
  gulp.start 'compile'

gulp.task 'default', ['clean'], ->
  gulp.start 'watch'
