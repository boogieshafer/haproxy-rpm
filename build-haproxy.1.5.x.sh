#!/bin/sh
haproxyver="1.5"
haproxyrel="4"
rpmrel="1"

rm -rf ~/rpmbuild/{BUILD,BUILDROOT}/haproxy* || true
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

echo "Building initial source rpm..."
rpmbuild -bs  haproxy.spec

echo "Using mock to build rpm..."
#mock -r epel-6-x86_64 ~/rpmbuild/SRPMS/haproxy-$haproxyver.$haproxyrel-$rpmrel.src.rpm
mock  ~/rpmbuild/SRPMS/haproxy-$haproxyver.$haproxyrel-$rpmrel.src.rpm

echo "Cleaning up..."
rm haproxy.spec