#!/bin/sh
haproxyver="1.5"
haproxyrel="8"
rpmrel="1"

rm -rf ~/rpmbuild/{BUILD,BUILDROOT,SRPMS}/haproxy* || true
rm  ~/rpmbuild/SOURCES/etc.logrotate.d.haproxy || true
mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,SOURCES,RPMS,SRPMS,tmp}
cp haproxy.spec.in haproxy.spec

sed -i "s|HAVER_REPLACE|$haproxyver|g" haproxy.spec
sed -i "s|HAREL_REPLACE|$haproxyrel|g" haproxy.spec
sed -i "s|RPMREL_REPLACE|$rpmrel|g" haproxy.spec

echo "Downloading sources..."
if [ ! -f ~/rpmbuild/SOURCES/haproxy-$haproxyver.$haproxyrel.tar.gz ];
then
    wget "http://www.haproxy.org/download/$haproxyver/src/haproxy-$haproxyver.$haproxyrel.tar.gz" -O ~/rpmbuild/SOURCES/haproxy-$haproxyver.$haproxyrel.tar.gz
fi

cp etc.logrotate.d.haproxy ~/rpmbuild/SOURCES/etc.logrotate.d.haproxy

echo "Building initial source rpm..."
rpmbuild -bs --define "srcrpm_no_dist 1" haproxy.spec

echo "Using mock to build rpm..."
#mock -r epel-6-x86_64 ~/rpmbuild/SRPMS/haproxy-$haproxyver.$haproxyrel-$rpmrel.src.rpm
#mock -r epel-7-x86_64 ~/rpmbuild/SRPMS/haproxy-$haproxyver.$haproxyrel-$rpmrel.src.rpm
mock  ~/rpmbuild/SRPMS/haproxy-$haproxyver.$haproxyrel-$rpmrel.src.rpm

echo "Cleaning up..."
rm haproxy.spec
