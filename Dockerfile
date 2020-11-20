FROM rstudio/plumber
MAINTAINER Ooi Wen Fong <raymondowf@gmail.com>

COPY ./api/ /usr/local/src/rconf2020-deploy
WORKDIR /usr/local/src/rconf2020-deploy

RUN chmod 700 start.sh

# Install R packages 
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('randomForest')"

# Port 8000 for local usage, not used on Heroku/AWS
EXPOSE 8000

ENTRYPOINT ["/usr/local/src/rconf2020-deploy/start.sh"]
#CMD ["demo3.R"]