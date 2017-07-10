basicAuth = require('basic-auth')

###*
# Simple basic auth middleware for use with Express 4.x.
#
# @example
# app.use('/api-requiring-auth', utils.basicAuth('username', 'password'));
#
# @param   {string}   username Expected username
# @param   {string}   password Expected password
# @returns {function} Express 4 middleware requiring the given credentials
###

exports.basicAuth = ->
  (req, res, next) ->
    user = basicAuth(req)
    if !user or user.name != process.env.HTTP_AUTH_USERNAME or user.pass != process.env.HTTP_AUTH_PASSWORD
      res.set 'WWW-Authenticate', 'Basic realm=Authorization Required'
      return res.send(401)
    next()
    return
