const { environment } = require('@rails/webpacker')

environment.config.set('resolve.alias', {jquery: 'jquery/src/jquery'});

module.exports = environment
