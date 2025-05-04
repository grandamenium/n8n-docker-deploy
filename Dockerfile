FROM n8nio/n8n:1.86.1

RUN apt-get update && apt-get install -y libreoffice

RUN mkdir -p /data/custom
WORKDIR /data/custom
RUN npm init -y && npm install pdf-parse mammoth textract

ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-parse,mammoth,textract
ENV N8N_CUSTOM_EXTENSIONS=/data/custom
ENV N8N_ENABLE_CUSTOM_FOLDERS=true

CMD ["n8n"]
