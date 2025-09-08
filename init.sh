#!/usr/bin/env bash

# проверка аргумента
if [[ $# -ne 1 ]]; then
  echo "Использование: $0 {server|client}"
  exit 1
fi

ENV_FILE=.env
# если env не создан то создаем
if [[ ! -f ENV_FILE ]]; then
  cp ".env.example" "${ENV_FILE}"
fi

TARGET="$1"
case "$TARGET" in
server | client) ;;
*)
  echo "Ошибка: допустимые аргументы — server или client"
  exit 1
  ;;
esac

# читаем конфиг в переменную
config=$(<"./config/${TARGET}.json")

# проходим по строкам .env
while IFS='=' read -r key value; do
  # пропускаем пустые и комментарии
  [[ -z "$key" || "$key" =~ ^# ]] && continue
  # убираем кавычки вокруг значения, если есть
  value="${value%\"}"
  value="${value#\"}"
  value="${value%\'}"
  value="${value#\'}"
  # делаем замену ${KEY} → value
  config="${config//$key/$value}"
done <${ENV_FILE}

# заполняем профиль и если не определен то переписываем
if grep -q "PROFILE=" ${ENV_FILE}; then
  sed -i "s|^PROFILE=.*|PROFILE=${TARGET}|" "$ENV_FILE"
else
  DESCRIPTION="# профиль для контейнера"
  echo -e "\n${DESCRIPTION}\nPROFILE=${TARGET}" >>${ENV_FILE}
fi

# пишем результат
printf '%s\n' "$config" >"./${TARGET}.json"
echo "✔ Сгенерирован ${TARGET}.json"
