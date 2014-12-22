haproxy-rpm
===========

A build process to create an haproxy RPM using mock.

RPM is for use on linux kernel 2.6.28+

To setup your build environment (if necessary):

	sudo yum upgrade -y
	sudo yum groupinstall -y development
	sudo yum install -y fedora-packager
	rpmdev-setuptree

Add build user to mock group

Add additional prerequisites for haproxy compile:

	sudo yum install -y pcre-devel openssl-devel

To build:

	git clone git@github.com:boogieshafer/haproxy-rpm.git
	cd haproxy-rpm
	./build-haproxy.1.5.x.sh

NOTE: 
	to enable USE_PCRE_JIT=1 option in haproxy requires PCRE > 8.20
        it is statically linked in this build to a current release
        this will workaround old distro version
        http://www.pcre.org

TODO:
	logic to use systemd scripts vs init on appropriate platforms
	include example ocsp_update script and cron job

Notes:

reference: http://www.haproxy.org

initial rpm spec file came from here
https://github.com/nmilford/rpm-haproxy
