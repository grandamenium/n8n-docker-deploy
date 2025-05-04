FROM n8nio/n8n:1.86.1

# Use Alpine's package manager to install LibreOffice
RUN apk update && apk add --no-cache libreoffice

# Set up custom modules
RUN mkdir -p /data/custom
WORKDIR /data/custom
RUN npm init -y && npm install pdf-parse mammoth textract

ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-parse,mammoth,textract
ENV N8N_CUSTOM_EXTENSIONS=/data/custom
ENV N8N_ENABLE_CUSTOM_FOLDERS=true

CMD ["n8n"]
