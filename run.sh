# puma -d -p 4567 -e production --pidfile pid
bundle exec thin start -d -p 4567 -e production --pid pid
