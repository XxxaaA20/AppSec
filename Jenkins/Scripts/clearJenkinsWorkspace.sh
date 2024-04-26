#!/bin/bash

#
# Очищаем workspace. Завершается джоб, запускает пост акшном этот скрипт и скрипт удаляет workspace с небольшой задержкой, чтобы попасть в тротл между джобами
#

JOB_NAME=$1

sleep 5s
echo $JOB_NAME
rm -rf $JOB_NAME*
rm -rf $JOB_NAME