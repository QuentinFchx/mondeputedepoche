npm update
npm run build
# Copy files into prod dir
cp -R dist/* /usr/share/nginx/www
