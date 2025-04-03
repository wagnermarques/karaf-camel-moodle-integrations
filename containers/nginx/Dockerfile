# ./nginx/Dockerfile
ARG NGINX_VERSION=alpine
FROM nginx:${NGINX_VERSION}

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom Nginx configuration
COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80
# If using HTTPS, also EXPOSE 443

# The base Nginx image already defines the CMD ["nginx", "-g", "daemon off;"]
