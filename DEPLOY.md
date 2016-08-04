===========================
apt-get update
apt-get upgrade
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
wget -qO- https://deb.nodesource.com/setup_6.x | bash -
apt-get install postgres
apt-get install esl-erlang
apt-get install elixir
apt-get install git-core
apt-get install redis-server
apt-get install nodejs
apt-get install nginx

============================
/etc/apt/sources.list.d/pgdg.list
deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main

============================
server {
    location / {
        # FRONT
        try_files $uri $uri/ /index.html;
        proxy_pass http://localhost:8080;
    }

    location /api/ {
        # API
        proxy_pass http://localhost:4000;
    }
}
