# use the normal Alpine image, then switch to root only for apk installs
FROM n8nio/n8n:1.86.1

# --- become root for package install (fixes apk Permission denied) ----------
USER root

# LibreOffice is optional – remove if you don't need PPTX / DOCX extraction
RUN apk update && apk add --no-cache libreoffice

# ---------------------------------------------------------------------------
# custom node‑modules for Function / Code nodes
RUN mkdir -p /data/custom
WORKDIR /data/custom
RUN npm init -y \
 && npm install --omit=dev pdf-parse mammoth textract

# keep modules on the disk Render mounts
ENV N8N_CUSTOM_EXTENSIONS=/data/custom
ENV NODE_FUNCTION_ALLOW_EXTERNAL=pdf-parse,mammoth,textract
ENV N8N_ENABLE_CUSTOM_FOLDERS=true
ENV N8N_EXECUTIONS_MODE=own

# ---------------------------------------------------------------------------
# drop privileges back to the n8n user for runtime safety
USER node

CMD ["n8n"]
