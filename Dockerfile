FROM ubuntu:18.04

# persistent / runtime deps
RUN apt-get update && apt-get install -y \
		ca-certificates \
		git \
		libsqlite3-dev \
                libsqlite3-0 \
                sqlite3 \
                sbcl \
                cl-quicklisp \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

#RUN sbcl --non-interactive --load install.lisp

WORKDIR /root/
#RUN touch .sbclrc
RUN sbcl --load /usr/share/cl-quicklisp/quicklisp.lisp --eval '(quicklisp-quickstart:install)'
#RUN sbcl --load /usr/share/cl-quicklisp/quicklisp.lisp --eval '(ql:add-to-init-file)'
RUN echo '  #-quicklisp (let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname)))) (when (probe-file quicklisp-init) (load quicklisp-init)))' > $HOME/.sbclrc

RUN git clone https://github.com/momozor/FCC-url-shortener-microservice.git 
#RUN echo '  #-quicklisp (let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname)))) (when (probe-file quicklisp-init) (load quicklisp-init)))' > /root/quicklisp/local-projects/FCC-url-shortener-microservice/.sbclrc

RUN mv FCC-url-shortener-microservice /root/quicklisp/local-projects/url-shortener-microservice; cd /root/quicklisp/local-projects/url-shortener-microservice; sh build-usm.sh
#RUN cd /root/quicklisp/local-projects/url-shortener-microservice
#RUN sh ./build-usm.sh
#CMD ["sbcl", "--eval", "(ql:quickload :url-shortener-microservice)", "--eval", "(url-shortener-microservice:start :port (parse-integer (uiop:getenv \"PORT\")))", "--eval", "(loop (sleep 1000))"]
CMD ["/root/quicklisp/local-projects/url-shortener-microservice/usm"]
