CREATE TABLE t1 (
    id UUID PRIMARY KEY,
    blob_object BYTEA,
    is_active BOOLEAN DEFAULT True
);
CREATE TABLE t2 (
    id UUID PRIMARY KEY
);