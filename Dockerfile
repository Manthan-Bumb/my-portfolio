FROM python:3.11-slim
# Create user with UID 1000
RUN useradd -m -u 1000 user
# Set working directory
WORKDIR /home/user/app
# Copy requirements and install dependencies
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt
# Copy application files
COPY --chown=user . .
# Switch to non-root user
USER user
# Set environment variables
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH \
    APP_PORT=7069 \
    HF_HOME=/data/.huggingface
# Expose the port
EXPOSE 7069
# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7069"]
