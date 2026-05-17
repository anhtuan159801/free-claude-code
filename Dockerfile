FROM python:3.10-slim

WORKDIR /app

# Clone mã nguồn từ repo của bạn (đã fork) – nhưng vì bạn đã fork, bạn có thể build từ source trực tiếp mà không cần clone.
# Tuy nhiên nếu bạn muốn build từ repo, Render sẽ tự copy code vào /app, nên chỉ cần cài dependencies.
COPY . .

# Cài đặt các gói phụ thuộc và tạo command fcc-server
RUN pip install --no-cache-dir .

# Tạo script entrypoint để ghi biến môi trường thành .env trước khi chạy server
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'printenv > /app/.env' >> /entrypoint.sh && \
    echo 'exec "$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["fcc-server"]
