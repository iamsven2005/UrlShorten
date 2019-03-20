#!/bin/sh

sbcl --load app.lisp --eval "(sb-ext:save-lisp-and-die \"usm\" :compression t :executable t :toplevel 'url-shortener-microservice:main)"
