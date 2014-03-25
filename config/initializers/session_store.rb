# Be sure to restart your server when you modify this file.

EKbri::Application.config.session_store :cookie_store, key: '_e-kbri_session'
EKbri::Application.config.session_store :mongoid_store
#By default, the sessions will be stored in the "sessions" collection in MongoDB. 
#If you want to use a different collection
MongoSessionStore.collection_name = "consular_sessions"
