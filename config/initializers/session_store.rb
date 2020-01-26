MockLeague::Application.config.session_store(
  :redis_store,
  servers: [MockLeague.credentials[:redis_server]],
  expire_after: 90.minutes,
  key: MockLeague.credentials[:redis_key],
  threadsafe: true,
  signed: true,
  secure: true
)
