FROM solr:6.6.6
MAINTAINER Open Knowledge

# Enviroment
ENV SOLR_CORE ckan
ENV CKAN_VERSION v2.9

# User
USER root

# Create Directories
RUN mkdir -p /opt/solr/server/solr/$SOLR_CORE/conf
RUN mkdir -p /opt/solr/server/solr/$SOLR_CORE/data

# Adding Files
ADD solrconfig.xml \
schema.xml \
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.0.0/solr/server/solr/configsets/basic_configs/conf/currency.xml \
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.0.0/solr/server/solr/configsets/basic_configs/conf/synonyms.txt \
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.0.0/solr/server/solr/configsets/basic_configs/conf/stopwords.txt \
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.0.0/solr/server/solr/configsets/basic_configs/conf/protwords.txt \
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.0.0/solr/server/solr/configsets/data_driven_schema_configs/conf/elevate.xml \
/opt/conf/

# Create Core.properties
RUN echo name=$SOLR_CORE > /opt/solr/server/solr/$SOLR_CORE/core.properties
RUN chown -R solr:solr /opt/solr/server/solr/ckan/conf/
# Giving ownership to Solr
#RUN chown -R $SOLR_USER:$SOLR_USER /opt/solr/server/solr/$SOLR_CORE
COPY start_solr.sh /opt/start_solr.sh
RUN chmod +x /opt/start_solr.sh
RUN chown solr:solr /opt/start_solr.sh
USER root
VOLUME ["/opt/solr/server/solr/ckan/data/index"]

CMD ["/opt/start_solr.sh"]

