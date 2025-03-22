# Imagem base de Ubuntu - versão LTS mais recente
FROM ubuntu:22.04

# Metadados da imagem
LABEL maintainer="Victor Luiz Almeida <victor.luiz.almeida.v@gmail.com>"
LABEL description="Ambiente de Python para Deep Learning com PyTorch usando UV para gerenciamento de pacotes (Atividade EML 1.1)"
LABEL version="1.0"

# Evita interações durante a instalação de pacotes
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza o sistema e instala dependências
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    curl \
    wget \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instala UV - gerenciador de pacotes Python moderno e rápido
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Adiciona UV ao PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Cria e configura o ambiente virtual com UV
RUN uv venv /opt/venv/python_para_deep_learning

# Configura o shell para usar o ambiente virtual automaticamente
ENV PATH="/opt/venv/python_para_deep_learning/bin:${PATH}"

# Instala PyTorch e dependências comuns para deep learning utilizando UV
RUN uv pip install \
    numpy \
    pandas \
    matplotlib \
    scikit-learn \
    torch \
    torchvision \
    torchaudio

# Cria um diretório para os projetos
WORKDIR /app

# Volume para persistência de dados e modelos
VOLUME ["/app/data", "/app/models"]

# Comando padrão ao iniciar o container
CMD ["python3", "--version"]

# Exemplo de uso:
# 1. Construa a imagem: docker build -t seu-usuario/pytorch-uv:1.0 .
# 2. Execute o container: docker run -it --rm -v $(pwd):/app seu-usuario/pytorch-uv:1.0 bash