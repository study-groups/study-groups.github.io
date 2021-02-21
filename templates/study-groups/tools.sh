VER=001
REPO=$(realpath "/home/$USER/src/webpage-study-group")
TEMPLATE=$(realpath $REPO/templates/study-groups)
BUILD=$(realpath ../../builds/study-groups)

tools-build(){
  rsync $TEMPLATE/index.html $BUILD/$VER/
  rsync $TEMPLATE/styleguide.html $BUILD/$VER/
  rsync $TEMPLATE/error.html $BUILD/$VER/
  cp -r $TEMPLATE/assets $BUILD/$VER/assets
}

tools-list-build(){
  ls -l $BUILD/$VER 
}
tools-publish(){
  local tmpdir=/tmp/$(date +%s)
  mkdir $tmpdir
  git stash push -m "$tmpdir"
 
  echo cp -r $BUILD/$VER/* /$tmpdir/
  cp -r $BUILD/$VER/* /$tmpdir/*

  git checkout gh-pages

  echo Continue? Hit ctrl-c to exit, return to continue.
  read varname

  git rm -r *
  cp -r $tmpdir/* .
  git add .
  git commit -m"Publishing version $VER."
  git push origin gh-pages
  rm -rf $tmpdir
  git stash pop
}

tools-clean(){
  echo executing: rm -r $BUILD/$VER
  rm -r $BUILD/$VER
}

tools-show-nginx(){

  cat /etc/nginx/sites-enabled/study-groups.org
}
