from oonib.bouncer import handlers
# XXX: if bouncer is configured
bouncerAPI = [
    # return a collector and helper of the requested type
    (r"/api/v1/collectors", handlers.APIv1Collectors),
    (r"/api/v1/test-helpers", handlers.APIv1TestHelpers),
    (r"/bouncer", handlers.BouncerQueryHandler),
    (r"/bouncer/test-helpers", handlers.BouncerTestHelpers),
    (r"/bouncer/net-tests", handlers.BouncerNetTests),
]
