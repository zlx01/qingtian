#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
yarn
yarn build

# 进入生成的文件夹
cd dist

git init
git add -A
git commit -m 'Deploy to GitHub Pages'

git push -f git@github.com:zlx01/vuepress-qingtian.git master:gh-pages

cd -
