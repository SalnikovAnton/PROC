# Управление процессами 
1) реализовать 2 конкурирующих процесса по CPU. пробовать запустить с разными nice
2) Результат ДЗ - скрипт запускающий 2 процесса с разными nice и замеряющий время выполнения и лог консоли


#### 1 Создаем скрипт который будет обробатывать два одинаковых временных файла. Файлы то же создадим через скрипт.
```
#!/bin/bash

rm -rf /tmp/archive_{low,high}.tar.gz > /dev/null 2>&1
echo "" > logproc.log

lowpriority() {

    echo "[`date`] Start low priority" > logproc.log

    nice -15 tar czvf /tmp/archive_low.tar.gz /boot/* > /dev/null  2>&1

    echo "[`date`] End low priority" >> logproc.log

}

hipriority() {

    echo "[`date`] Start high priority" >> logproc.log

    nice --19 tar czvf /tmp/archive_high.tar.gz /boot/* > /dev/null  2>&1

    echo "[`date`] End high priority" >> logproc.log

}

lowpriority &
hipriority &

cat logproc.log

```
Результат вывода лог файла

```
[Вт 21 фев 2023 20:17:33 MSK] Start low priority
[Вт 21 фев 2023 20:17:33 MSK] Start high priority
[Вт 21 фев 2023 20:17:41 MSK] End high priority
[Вт 21 фев 2023 20:17:43 MSK] End low priority
```
По выводу в лог-файл видно что команда имеющая более высокий приоритет выполняется быстрее
