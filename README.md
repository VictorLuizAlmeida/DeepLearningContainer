# DeepLearningContainer

Esse Dockerfile visa criar um ambiente python pronto para uso de Pytorch.

Ele parte de uma imagem base linux, e utiliza UV (gerenciamento de pacotes python de alta performance em RUST) para instalar todas as dependências.

# Exemplo de uso:
# 1. Construa a imagem: docker build -t seu-usuario/pytorch-uv:1.0 .
# 2. Execute o container: docker run -it --rm -v $(pwd):/app seu-usuario/pytorch-uv:1.0 bash
