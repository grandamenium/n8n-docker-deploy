FROM n8nio/n8n:1.86.1            # Alpine base, n8n already installed

# stay root for everything (avoids PATH / permission surprises)
USER root

# OS packages you need for textract PPTX/DOCX support
RUN apk update && apk add --no-cache libreoffice

# custom Node modules for Function / Code nodes
RUN mkdir -p /data/custom
WORKDIR /data/custom
RUN npm init -y \
 && npm install --omit=dev pdf-parse mammoth textract

# expose modules to n8n
ENV N8N_CUSTOM_EXTENSIONS=/data/custom
ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-parse,mammoth,textract
ENV N8N_ENABLE_CUSTOM_FOLDERS=true
ENV N8N_EXECUTIONS_MODE=own

# run n8n (binary is in /usr/local/bin, always on root’s PATH)
CMD ["n8n"]
