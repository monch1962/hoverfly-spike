FROM spectolabs/hoverfly:latest
RUN apk --no-cache add ca-certificates python3 py3-pip
COPY . /middleware/
RUN pip3 install -r /middleware/requirements.txt
ENTRYPOINT ["/bin/hoverfly", "-listen-on-host=0.0.0.0"]
CMD [""]

EXPOSE 8500 8888