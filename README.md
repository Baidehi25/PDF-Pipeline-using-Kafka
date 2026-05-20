# PDF Pipeline using Kafka

A data engineering pipeline that stores PDF files in a PostgreSQL database and uses Apache Kafka to track their processing status.

## What This Project Does

1. PDFs are read from a local folder and stored as binary data in PostgreSQL (T1)
2. Each PDF is assigned a unique UUID and is_active is set to True by default
3. A Kafka Producer reads all active UUIDs from T1, inserts them into T2, and sends each UUID as a message to a Kafka topic
4. A Kafka Consumer listens to that topic and updates is_active to False in T1 when a UUID is received

## Tech Stack

- PostgreSQL 18
- Apache Kafka (via Docker)
- Python 3.14
- psycopg2-binary
- confluent-kafka
- Docker & Docker Compose

## How to Run This Project

### Prerequisites
- PostgreSQL installed
- Docker Desktop installed
- Anaconda or Python 3.10+

### Setup

1. Clone the repo
```bash
git clone https://github.com/yourusername/pdf-pipeline-kafka.git
```

2. Create and activate conda environment
```bash
conda create -n pdf_pipeline python=3.10
conda activate pdf_pipeline
pip install -r requirements.txt
```

3. Set up the database
- Open pgAdmin
- Create a database called `pdf_pipeline`
- Run `schema.sql` to create the tables

4. Start Kafka
```bash
docker-compose up
```

5. Create the Kafka topic
```bash
docker exec -it kafka kafka-topics --create --topic pdf_processed \
--bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
```

6. Add PDFs to the `sample_pdfs` folder

7. Run the notebooks in order:
   - `pdf_pipeline.ipynb` — inserts PDFs into T1
   - `producer.ipynb` — sends UUIDs to Kafka
   - `consumer.ipynb` — listens and updates T1

## What I Learned

- Storing binary data (BYTEA) in PostgreSQL
- Why UUIDs are preferred over auto-increment IDs in distributed systems
- How Kafka decouples producers and consumers using topics
- Running Kafka locally using Docker instead of manual installation
- How KRaft mode eliminates the need for Zookeeper in modern Kafka
