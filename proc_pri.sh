#!/bin/bash

rm -rf /tmp/archive_{low,high}.tar.gz > /dev/null 2>&1
echo "" > logproc.log

lowpriority() {

    echo "[`date`] Старт команды с низким приоритетом" > logproc.log

    nice -15 tar czvf /tmp/archive_low.tar.gz /boot/* > /dev/null  2>&1

    echo "[`date`] Окончание выполнения команды с низким приоритетом" >> logproc.log

}

hipriority() {

    echo "[`date`] Старт команды с высоким приоритетом" >> logproc.log

    nice --19 tar czvf /tmp/archive_high.tar.gz /boot/* > /dev/null  2>&1

    echo "[`date`] Окончание выполнения команды с высоким приоритетом" >> logproc.log

}

lowpriority &
hipriority &

cat logproc.log
