haproxy-rpm
===========

A build process to create an haproxy RPM using mock.

To setup your build environment (if necessary):
	sudo yum upgrade -y
	sudo yum groupinstall -y development
	sudo yum install -y fedora-packager
	rpmdev-setuptree

Add additional prerequisites for haproxy compile:
	sudo yum install -y pcre-devel openssl-devel

To build:
	git clone git@github.com:boogieshafer/haproxy-rpm.git
	cd haproxy-rpm
	./build-haproxy.1.5.x.sh


TODO:
	init script for EL7

Notes:

reference: http://www.haproxy.org

initial rpm spec file came from here
https://github.com/nmilford/rpm-haproxy
