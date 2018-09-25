#!/usr/bin/env bash
git clone git@github.internet2.edu:docker/util.git
find util/bin -name "*.sh" -exec sh -c 'echo "$1" | sed "s/util\///" >> .gitignore' -- {} \;
mkdir -p bin
mv util/bin/* bin/.
mv util/README.md BINSCRIPTS.md
if [ ! -f common.bash ]; then
  mv util/common.bash.sample common.bash
fi
if [ ! -f Jenkinsfile ]; then
  mv util/Jenkinsfile.sample Jenkinsfile
fi
rm -rf util
