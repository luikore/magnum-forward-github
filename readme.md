# Forward magnum-ci build status to github

### Running

1. Generate access token in github personal settings -> applications -> personal access tokens.
2. Copy `config.example.yml` to `confi.yml`, and fill access_token and repo name.
3. `bundle`
4. `./run.sh` and then the server is up on port `4567`, you need to config magnum notification settings (the path is `/ci-forward-github`) to make the whole thing working.

### To config nginx front-end

    location ~ ^/ci-forward-github/ {
      proxy_redirect off;
      proxy_pass http://localhost:4567;
    }

### To simply test the status

    test-status=1 ./run.sh
    curl localhost:4567/ci-forward-github/status
