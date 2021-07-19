FROM postgres:13@sha256:2b87b5bb55589540f598df6ec5855e5c15dd13628230a689d46492c1d433c4df
COPY add-readonly-user.sh /docker-entrypoint-initdb.d/
