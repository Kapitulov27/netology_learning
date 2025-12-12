FROM python:3.12-slim
WORKDIR /app
RUN apt install -y procps psmisc

COPY requirements.txt  main.py ./
RUN pip install -r requirements.txt
RUN echo "hello"
CMD ["python", "main.py"]