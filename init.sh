#!/usr/bin/env bash

# проверка аргумента
if [[ $# -ne 1 ]]; then
  echo "Использование: $0 {server|client}"
  exit 1
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
done <.env

# пишем результат
printf '%s\n' "$config" >"./${TARGET}.json"
echo "✔ Сгенерирован ${TARGET}.json"
