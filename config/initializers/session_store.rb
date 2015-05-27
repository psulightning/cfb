# Be sure to restart your server when you modify this file.

require 'action_dispatch/middleware/session/dalli_store'
Baltbear::Application.config.session_store :dalli_store, key: '_baltbear_session', expire_after: 2.hours
