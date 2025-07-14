FROM python:3.11-slim

# direcctorio de trabajo
WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# copia todo
COPY . .

EXPOSE 5000

CMD ["flask", "run"]