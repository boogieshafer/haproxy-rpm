haproxy-rpm
===========

A build process to create a more enhanced haproxy RPM using mock

-HTTPS enabled using self-signed certificate
-HTTP compression enabled
-up to date PCRE included
-additional scripts for OCSP support and cert management
-default config incorporating suggested cipher suite

updated for haproxy version 1.5.14 and PCRE version 8.37

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

Notes:
	PCRE is statically linked into this haproxy build
	this will workaround older distro versions of PCRE
	http://www.pcre.org

	config is in /etc/haproxy/haproxy.cfg

	this rpm will generate a selfsigned certificate for HTTPS on install


Manage:
	https://haproxy_host.domain.com/haproxy_stats

           administrative permissions
                 username: admin, password: AdMiN123
           read only permissions
                 username: haproxy, password: haproxy

	regular haproxy usage recommendations
         - to "preflight-check" a new config
	   sudo /etc/init.d/haproxy check

         - to apply new config with minimal interruption to clients
	   sudo /etc/init.d/haproxy reload

         - to perform a full reset on haproxy
	   sudo /etc/init.d/haproxy restart

TODO:
	native systemd init script for newer platforms


reference: http://www.haproxy.org

initial rpm spec file came from https://github.com/nmilford/rpm-haproxy
