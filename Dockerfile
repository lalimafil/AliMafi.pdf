# =============================
# Dockerfile: Serve LaTeX CV as PDF
# Base image: nginx
# =============================

FROM nginx:alpine

WORKDIR /app

RUN apk add --no-cache curl tar bash wget 

RUN wget https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic%400.15.0/tectonic-0.15.0-x86_64-unknown-linux-musl.tar.gz

RUN tar -xvf tectonic-0.15.0-x86_64-unknown-linux-musl.tar.gz

COPY . /app/

RUN ./tectonic -X build

RUN cp ./build/AliMafi/AliMafi.pdf /usr/share/nginx/html/AliMafi.pdf

RUN cp -f ./index.html /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]