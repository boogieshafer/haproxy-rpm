#!/bin/sh
haproxyver="1.5"
haproxyrel="12"
rpmrel="1"
pcrever="8.37"

rm -rf ~/rpmbuild/{BUILD,BUILDROOT,SRPMS}/haproxy* || true
rm  ~/rpmbuild/SOURCES/etc.logrotate.d.haproxy || true
mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,SOURCES,RPMS,SRPMS,tmp}
cp haproxy.spec.in haproxy.spec

sed -i "s|HAVER_REPLACE|$haproxyver|g" haproxy.spec
sed -i "s|HAREL_REPLACE|$haproxyrel|g" haproxy.spec
sed -i "s|RPMREL_REPLACE|$rpmrel|g" haproxy.spec
sed -i "s|PCREVER_REPLACE|$pcrever|g" haproxy.spec

echo "Downloading sources..."
if [ ! -f ~/rpmbuild/SOURCES/haproxy-$haproxyver.$haproxyrel.tar.gz ];
then
    wget "http://www.haproxy.org/download/$haproxyver/src/haproxy-$haproxyver.$haproxyrel.tar.gz" -O ~/rpmbuild/SOURCES/haproxy-$haproxyver.$haproxyrel.tar.gz
fi

if [ ! -f ~/rpmbuild/SOURCES/pcre-$pcrever.tar.gz ];
then
    wget "http://sourceforge.net/projects/pcre/files/pcre/$pcrever/pcre-$pcrever.tar.gz" -O ~/rpmbuild/SOURCES/pcre-$pcrever.tar.gz
fi

cp haproxy.cfg ~/rpmbuild/SOURCES/haproxy.cfg
cp etc.logrotate.d.haproxy ~/rpmbuild/SOURCES/etc.logrotate.d.haproxy
cp etc.cron.d.haproxy-ocsp ~/rpmbuild/SOURCES/etc.cron.d.haproxy-ocsp
cp certs/ocsp-update.sh ~/rpmbuild/SOURCES/ocsp-update.sh
cp certs/build_haproxy_combined_pem.sh ~/rpmbuild/SOURCES/build_haproxy_combined_pem.sh
cp certs/make_selfsigned_cert.sh ~/rpmbuild/SOURCES/make_selfsigned_cert.sh
cp etc.rsyslog.d.haproxy.conf ~/rpmbuild/SOURCES/etc.rsyslog.d.haproxy.conf

echo "Building initial source rpm..."
rpmbuild -bs --define "srcrpm_no_dist 1" haproxy.spec

echo "Using mock to build rpm..."
#mock -r epel-6-x86_64 ~/rpmbuild/SRPMS/haproxy-$haproxyver.$haproxyrel-$rpmrel.src.rpm
#mock -r epel-7-x86_64 ~/rpmbuild/SRPMS/haproxy-$haproxyver.$haproxyrel-$rpmrel.src.rpm
mock  ~/rpmbuild/SRPMS/haproxy-$haproxyver.$haproxyrel-$rpmrel.src.rpm

echo "Cleaning up..."
rm haproxy.spec
