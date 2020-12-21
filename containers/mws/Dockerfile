### My webMethods Server image

# Arguments
ARG BUILDER_IMAGE
ARG BASE_IMAGE

# Source image
FROM $BUILDER_IMAGE as builder

# Install PostgreSQL
USER 0
RUN yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
    yum install -y postgresql10-server && \
    yum clean all && \
    chown 1724 /var/run/postgresql
USER 1724

# Provision, unit test, cleanup
RUN mkdir -p $CC_HOME/pgsql/data && \
    echo mws > $CC_HOME/pgsql/pwd && \
    /usr/pgsql-10/bin/initdb -D $CC_HOME/pgsql/data --auth=trust --auth-host=md5 --locale=en_US.utf8 --username=mws --pwfile=$CC_HOME/pgsql/pwd && \
    /usr/pgsql-10/bin/pg_ctl start -D $CC_HOME/pgsql/data -w && \
    /usr/pgsql-10/bin/createdb mws --username=mws --locale=en_US.utf8 && \
    $CC_HOME/provision.sh && $CC_HOME/test.sh && $CC_HOME/cleanup.sh && \
    /usr/pgsql-10/bin/pg_ctl stop -D $CC_HOME/pgsql/data -w -m fast && \
    rm -Rf $CC_HOME/pgsql

# Target image
FROM $BASE_IMAGE

# Expose ports
EXPOSE 8585 8586 8587 8092 8093

# Copy install directory from builder image
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# Add overlay from target directory
ADD --chown=1724:1724 target/ $SAG_HOME/

# Entrypoint script
ENTRYPOINT ["/opt/softwareag/entrypoint.sh"]
