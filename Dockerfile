FROM image-registry.openshift-image-registry.svc:5000/webhook-app/node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# --- NGINX ---
FROM image-registry.openshift-image-registry.svc:5000/webhook-app/nginx:alpine

# Ajustar permissões para qualquer UID (OpenShift)
RUN mkdir -p /var/cache/nginx/client_temp \
    /var/cache/nginx/proxy_temp \
    && chmod -R 777 /var/cache/nginx /etc/nginx /usr/share/nginx

# Copia build do React
COPY --from=build /app/build /usr/share/nginx/html

# Copia config customizada para rodar na porta 8080
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
