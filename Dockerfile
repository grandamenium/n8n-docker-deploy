# Alpine‑based image that already contains n8n
FROM n8nio/n8n:1.86.1

# ──────────────────────────────────────────
# stay root for everything (avoids PATH / permission surprises)
USER root

# OS packages for pptx/docx extraction (optional)
RUN apk update && apk add --no-cache libreoffice

# custom Node modules for Code / Function nodes
RUN mkdir -p /data/custom
WORKDIR /data/custom
RUN npm init -y \
 && npm install --omit=dev pdf-parse mammoth textract

# make n8n load them
ENV N8N_CUSTOM_EXTENSIONS=/data/custom
ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-parse,mammoth,textract
ENV N8N_ENABLE_CUSTOM_FOLDERS=true
ENV N8N_EXECUTIONS_MODE=own

CMD ["n8n"]
