path = require 'path'
_ = require 'lodash'

HtmlWebpackPlugin = require 'html-webpack-plugin'
VueLoaderPlugin = require 'vue-loader/lib/plugin'
MiniCssExtractPlugin = require 'mini-css-extract-plugin'

WEBPACK_CONFIG =
	context: path.join __dirname,'src'
	entry: './scripts/main.coffee'
	output:
		filename: 'main.js'
	target: 'web'
	module:
		rules: [
			test: /\.vue$/,
			loader: 'vue-loader'
		,
			test: /\.js$/,
			use: [
				'babel-loader'
			]
		,
			test: /\.coffee$/,
			loader: 'coffee-loader'
		,
			test: /\.s?css$/
			use: [
				MiniCssExtractPlugin.loader,
				'css-loader',
				'sass-loader'
			]
		]
	plugins: [
		new HtmlWebpackPlugin
			template: 'index.html'
	,
		new VueLoaderPlugin()
	,
		new MiniCssExtractPlugin
			filename: "[name].css"
	]
	resolve:
		extensions: ['.vue', '.js','.coffee']
		modules: ['src/scripts','node_modules']

getWebpackConfig = (options={})->
	config = _.cloneDeep WEBPACK_CONFIG

	if options.devMode
		config.mode = 'development'
		config.devtool = 'inline-source-map'
	else
		config.mode = 'production'

	config


module.exports = (grunt)->
	require('load-grunt-tasks')(grunt)
	require('time-grunt')(grunt)

	grunt.initConfig

		webpack:
			appDev: getWebpackConfig
				devMode: true

			appProd: getWebpackConfig()

		'webpack-dev-server':
			options:
				webpack: getWebpackConfig
					devMode: true
				host: '0.0.0.0'
				open: true
				port: 8338
				compress: true
				disableHostCheck: true

		grunt.registerTask 'serve', [
			'webpack-dev-server:appDev'
		]
