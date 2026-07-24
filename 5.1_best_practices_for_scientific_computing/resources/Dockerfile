FROM python:3.12-slim

WORKDIR /opt/skydiver

COPY tutorial/skydiver/pyproject.toml tutorial/skydiver/README.md ./
COPY tutorial/skydiver/skydiver ./skydiver

RUN python -m pip install --no-cache-dir .

ENTRYPOINT ["python", "-m", "skydiver.cli"]
