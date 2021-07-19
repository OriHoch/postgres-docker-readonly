# Postgres Docker image with a readonly-user

## Usage

Set env vars:

```
export POSTGRES_PASSWORD=123456
export READONLY_USER=testreadonly
export READONLY_PASSWORD=654321
```

Build and run a DB:

```
docker build -t postgres-readonly . && docker run --rm --name postgres-readonly \
    -e POSTGRES_PASSWORD -e READONLY_USER -e READONLY_PASSWORD \
    -p 5432:5432 \
    -v $(pwd)/.data:/var/lib/postgresql/data \
    -d postgres-readonly
```

Wait a few seconds for DB to start

Create a table using the admin user

```
echo "create table test (foo text);" | PGPASSWORD=123456 psql -h localhost -U postgres postgres
```

Select from the table using the readonly user:

```
echo "select * from test;" | PGPASSWORD=654321 psql -h localhost -U testreadonly postgres
```

Try to insert data using the readonly user (should fail with permission denied):

```
echo "insert into test (foo) values ('bar');" | PGPASSWORD=654321 psql -h localhost -U testreadonly postgres
```

Restart the container

```
docker restart postgres-readonly
```

Check the logs - see that init code does not run again and readonly user still has access
