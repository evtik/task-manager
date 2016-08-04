var gulp = require('gulp'),
	gutil = require('gulp-util'),
	nodemon = require('gulp-nodemon'),
	livereload = require('gulp-livereload'),
	open = require('gulp-open'),
	iced = require('gulp-iced'),
	browserify = require('browserify'),
	icsify = require('icsify'),
	watch = require('gulp-watch'),
	plumber = require('gulp-plumber'),
	tap = require('gulp-tap'),
	streamify = require('gulp-streamify'),
	concat = require('gulp-concat'),
	stylus = require('gulp-stylus'),
	jade = require('gulp-jade');

gulp.task('iced', function(){
	gulp.src('./src/server/**/*.iced')
		.pipe(iced({
			bare: true,
			runtime:'inline'
		}).on('error', gutil.log))
		.pipe(gulp.dest('./dist'))
});

gulp.task('bundle', function(){
	gulp.src('./src/client/application.iced', {read: false})
		.pipe(plumber())
		.pipe(tap(function(file){
			var d = require('domain').create();
			d.on('error', function(err){
				gutil.log(gutil.colors.red("Browserify compile error:"),
					gutil.colors.yellow(err.message),
					gutil.colors.red("in line"),
					gutil.colors.yellow(err.line),
					gutil.colors.red("column"),
					gutil.colors.yellow(err.column));
				gutil.beep();
				this.emit('end');
			});
			d.run(function(){
				file.contents = browserify({
					entries: [file.path],
					extensions: ['.iced'],
					debug: true
				}).transform(icsify).bundle();
			});
		}))
		.pipe(streamify(concat('bundle.js')))
		.pipe(gulp.dest('./dist/public/js'))

	gulp.src(__filename)
		.pipe(livereload());
});

gulp.task('jade', function(){
	gulp.src('./src/client/**/**/*.jade')
		.pipe(jade())
		.pipe(gulp.dest('./dist/public'))
		.pipe(livereload());
});

gulp.task('stylus', function(){
	gulp.src('./src/client/stylus/style.styl')
		.pipe(stylus({
			'include css': true
		}))
		.pipe(gulp.dest('./dist/public/css'))
		.pipe(gulp.src('./dist/server.js')
			.pipe(livereload()));
});

gulp.task('watch', function(){
	gulp.watch('./src/server/**/*.iced', ['iced']);
	gulp.watch('./src/client/**/*.iced', ['bundle']);
	gulp.watch('./dist/app/views/*.jade', function(){
		gulp.src('./dist/server.js')
			.pipe(livereload());
	});
	gulp.watch('./src/client/**/**/*.jade', ['jade']);
	gulp.watch('./src/client/stylus/**/*.styl', ['stylus']);
});

gulp.task('open', function(){
	var options = {
		uri: 'http://localhost:3000',
		app: 'chrome'
	};
	gulp.src(__filename)
	.pipe(open(options));
});

gulp.task('default', ['open', 'iced', 'bundle', 'jade', 'stylus', 'watch'], function(){
	livereload.listen();
	nodemon({
		script: 'dist/server.js',
		ext: 'js html css',
		verbose: true,
		delay: 200
	}).on('readable', function(chunk){
		if(/^running/.test(chunk)){
			livereload.reload();
		}
		process.stdout.write(chunk);
	});
});