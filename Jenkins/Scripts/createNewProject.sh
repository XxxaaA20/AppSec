#!/bin/bash
# Даем скрипту ссылку на репозиторий и в дженкинсе создается каталог под этот проект

#
# Задаем путь до каталога с джобами в переменную
#
jobsHomePath="/var/lib/jenkins/jobs/"
echo "jobsHomePath = $jobsHomePath"

#
# Проверяем из какой системы пришел запрос (Gitlab или Bitbucket)
#
if echo $1 | grep -q "gitlab.com"; then
  echo "===GITLAB==="
  #
  # Получаем полный путь до проекта из ссылки в формате "https://gitlab.com/proc/repo" и добавляем в каждый уровень вложенную папку jobs
  #
  projectPath=$(echo $1 | sed "s/https:\/\/gitlab.com\///g" | sed "s/\([^/]*\)/\1-gitlab/" | sed "s|\/|\/jobs\/|g")
elif echo $1 | grep -q "stash.com"; then
  echo "===BITBUCKET==="
  #
  # Получаем полный путь до проекта из ссылки в формате "https://stash.com/projects/BANKING/repos/moneymoney/browse" и добавляем в каждый уровень вложенную папку jobs
  #
  if echo $1 | grep -q "\\/projects\\/"; then
    projectPath=$(echo $1 | sed "s/https:\/\/stash.com\/projects\///g" | sed "s/\([^/]*\)/\1-bitbucket/" | sed "s|\/|\/jobs\/|g")
  #
  # Получаем полный путь до проекта из ссылки в формате "https://stash.com/users/user13/repos/mqgetter/browse" и добавляем в каждый уровень вложенную папку jobs
  #
  elif echo $1 | grep -q "\\/users\\/"; then
    projectPath=$(echo $1 | sed "s/https:\/\/stash.com\/users\///g" | sed "s/\([^/]*\)/\1-bitbucket/" | sed "s|\/|\/jobs\/|g")
  fi
else
  echo "ERROR - Bad link"
  exit 1
fi

#
# Добавляем каталог jobs в самый последний каталог для соблюдения структуры плагина Folders
#
projectPath=$projectPath"/jobs"
echo "projectPath = $projectPath"

#
# Записываем в переменную полный путь до каталога с джобами
#
fullPath=$jobsHomePath$projectPath
echo "fullPath = $fullPath"

#
# Получаем из fullPath наименование корневого каталога.F.e. Корневой каталог для "https://gitlab.com/proc/repo" - proc. Нужно, чтобы сменить владельца файлов
#
firstFolder=$(echo $projectPath | sed 's|/.*||g')
echo "firstFolder = $firstFolder"

#
#
#
if [ -d "$fullPath" ]; then
  echo "Folder exist"
  echo $fullPath
  exit 0
fi

#
# Создаем цепочку каталогов
#
echo "Creating Folder"
mkdir -p $fullPath

#
# Копируем в конечный каталог джобы
#
if echo $1 | grep -q "gitlab.com"; then
  cp -r /var/lib/jenkins/jobs/0_TEMPLATE_SCANNERS/jobs/* $fullPath
elif echo $1 | grep -q "stash.com"; then
  cp -r /var/lib/jenkins/jobs/0_TEMPLATE_SCANNERS/jobs/* $fullPath
else
  echo "Shit happens"
  exit 1
fi

#
# Заменяем в fullPath все слеши / на палки | чтобы корректно отработал следующий алгоритм. Если не заменить, то разделитель слеш / потом всегда будет заменяться на пробел
#
projectPathShort=$(echo $fullPath | sed 's|/var/lib/jenkins/jobs/||g')
echo "projectPathShort = $projectPathShort"
projectPathShort=$(echo $projectPathShort | sed 's/\//|/g')
projectPathShort=$jobsHomePath$projectPathShort
echo "projectPathShort222 = $projectPathShort"
IFS='|'
read -a list <<< "$projectPathShort"
if echo $1 | grep -q "gitlab.com"; then
  for word in "${list[@]}";
  do
    if [ "$word" = "jobs" ]; then
    cp /var/lib/jenkins/jobs/0_TEMPLATE_SCANNERS/config.xml $path
    fi
    path+=${word}"/"
  done
elif echo $1 | grep -q "stash.com"; then
  for word in "${list[@]}";
  do
    if [ "$word" = "jobs" ]; then
    cp /var/lib/jenkins/jobs/0_TEMPLATE_SCANNERS/config.xml $path
    fi
    path+=${word}"/"
  done
else
  echo "Fucking Motherfucking"
  exit 1
fi

#
# Меняем владельца файлов корневого каталога проекта
#
echo "Changing permissions"
chown -R jenkins:jenkins $jobsHomePath$firstFolder

#
# Перечитываем данные после внесения изменений в файлы на хосте
#
java -jar /usr/local/bin/jenkins-cli.jar -auth user:token -s http://localhost:8080 reload-configuration
