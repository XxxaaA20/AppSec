#!/bin/bash
#Скрипт удаляет из ссылки на репозиторий всё, кроме пути до файла, чтобы корректно запускать нужный пайплайн в правильном каталоге. Приписывает -gitlab или -bitbucket в зависимости от системы

if echo $1 | grep -q "gitlab.tochka-tech.com"; then
  echo $1 | sed 's/https:\/\/gitlab.tochka-tech.com\///g' | sed -z 's/\.git\n//' | sed 's/\([^/]*\)/\1-gitlab/'
elif echo $1 | grep -q "stash.bank24.int"; then
  echo $1 | sed 's/https:\/\/stash.bank24.int\/projects\///g' | sed -z 's/browse\n/browse/' | sed 's/\([^/]*\)/\1-bitbucket/'
else
  echo "ERROR - Bad link"
  exit 1
fi