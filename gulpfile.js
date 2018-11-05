const gulp = require('gulp')
const shell = require('gulp-shell')

const cwd = './'

gulp.task('setup', shell.task('./scripts/setup.sh', { cwd }))

gulp.task('start', shell.task('./scripts/start.sh', { cwd }))

gulp.task('restart', shell.task('docker-compose restart', { cwd }))

gulp.task('stop', shell.task('./scripts/stop.sh', { cwd }))

gulp.task('flush', shell.task('./scripts/flush.sh', { cwd }))

gulp.task('logs', shell.task('docker-compose logs -f', { cwd }))

gulp.task('migrate', shell.task('docker-compose up flyway', { cwd }))

gulp.task('psql', shell.task('docker-compose exec postgres psql -U postgres', { cwd }))
