#! /bin/bash

git checkout master
git add -A
git commit -m "博客发布"
cp -r _site/ /tmp/
git checkout gh-pages
#rm -r ./*
cp -r /tmp/_site/* ./
git add -A
git commit -m "deploy blog"
git push origin gh-pages
git checkout master
echo "发布成功"
