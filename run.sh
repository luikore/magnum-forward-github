# puma -d -p 4567 -e production --pidfile pid
thin start -d -p 4567 -e production --pid pid
