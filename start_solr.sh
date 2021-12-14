ls -lrt /opt/conf
mkdir -p /opt/solr/server/solr/ckan/conf/
cp -r /opt/conf/* /opt/solr/server/solr/ckan/conf/
chown -R $SOLR_USER:$SOLR_USER /opt/solr/server/solr/$SOLR_CORE
solr-foreground -force
