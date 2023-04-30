FROM node:18-buster-slim

ENV PNPM_VERSION v7.30.0
ENV HELM_VERSION v3.10.0
ENV KUBERNETES_VERSION v1.25.3

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \  
  ca-certificates \
  curl \
  git \ 
  gnupg \ 
  htop \
  openssh-client \
  python2 \
  python3 \
  jq \ 
  postgresql-client \
  sudo \ 
  vim \ 
  wget \
  zstd \
  libgtk2.0-0 \
  libgtk-3-0 \
  libgbm-dev \
  libnotify-dev \
  libgconf-2-4 \
  libnss3 \
  libxss1 \
  libasound2 \
  libxtst6 \
  xauth \
  xvfb && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
  echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" | tee /etc/apt/sources.list.d/docker.list && \
  apt-get update && \
  apt-get install --no-install-recommends -y docker-ce && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://github.com/pnpm/pnpm/releases/download/$PNPM_VERSION/pnpm-linuxstatic-x64" -o /bin/pnpm && chmod +x /bin/pnpm
RUN usermod -aG docker node

USER node

WORKDIR /app

CMD ["pnpm", "start"]