# MosDroid CI

В этом репозитории пошагово расписан путь от неработающего CI без эмулятора до прекрасного работающего CI с эмулятором и в Docker.
Реализация: 
- Stage1 - в виде bash скрипта без эмулятора
- Stage2 - переводим в Docker. Без эмулятора
- Stage3 - фикс проблемы с локалью
- Stage4 - добавляем эмулятор
- StageFinal - запускаем на базе google images рабочий билд с эмулятором

### Выступление на YouTube

[![](http://img.youtube.com/vi/1EiOJ2BpW0g/0.jpg)](http://www.youtube.com/watch?v=1EiOJ2BpW0g "")

### Документация
- Презентация: https://yadi.sk/i/IjB8M2L7OByjaw
- AvdManager: https://developer.android.com/studio/command-line/avdmanager
- Emulator Command Line: https://developer.android.com/studio/run/emulator-commandline
- Emulator By Google: https://androidstudio.googleblog.com/2019/05/emulator-ci-docker-scripts-for-linux.html

### Ссылки на готовые решения
- [LionZXY/google-android-emulator](https://github.com/LionZXY/google-android-emulator) ([DockerHub](https://cloud.docker.com/repository/docker/lionzxy/google-android-emulator))
- [LionZXY/gitlab-ci-emulator](https://github.com/LionZXY/gitlab-ci-emulator) ([DockerHub](https://cloud.docker.com/repository/docker/lionzxy/gitlab-ci-emulator))

### Требования к железу
- Поддержка KVM
- Docker контейнер запускать из под `priveleged` мода
- Ubuntu
